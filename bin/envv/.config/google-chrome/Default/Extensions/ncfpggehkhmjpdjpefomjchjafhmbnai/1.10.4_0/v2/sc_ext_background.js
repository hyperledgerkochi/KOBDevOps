/**
 * Copyright 2004-present Facebook. All Rights Reserved.
 *
 * @noformat
 * @haste-ignore
 * @nolint
 */

/**
 * KNOWN ISSUES:
 *
 * Audio sharing is only available as of Chrome 51 on Windows
 * https://crbug.com/603259
 *
 * Audio only (no window or tab) is not supported
 * https://crbug.com/769388
 *
 * Capturing a tab using chooseDesktopMedia is not supported in older versions
 * on Mac. A bug number identifying when this was fixed can not be found. The
 * solution is to check for a specific exception message and try to invoke the
 * media picker with only "screen" and "window".
 */

/**
 * WARNING!!!
 * When formatting this file with prettier we need to maintain ES5 compatibility
 * for older versions of Chrome.
 *
 * Use the following command line options
 *
 *    prettier --trailing-comma es5
 */

/*
 * When an appplication disconnects from the notifications port we should clear
 * all notifications that the application has produced. This ensures that all
 * notifications will be removed in case we are unable to clear them from the
 * application.
 */
var NotitifcationManager = {
  notifications: {},
  addNotificationId: function addNotificationId(sender, notificationId) {
    if (sender.tab !== undefined && sender.tab.id !== undefined) {
      var id = sender.tab.id;
      var notifications = this.notifications;

      if (notifications[id] === undefined) {
        notifications[id] = {};
      }

      notifications[id][notificationId] = true;
    }
  },
  clearAllNotifications: function clearAllNotifications(sender) {
    if (sender.tab !== undefined && sender.tab.id !== undefined) {
      var id = sender.tab.id;
      var notifications = this.notifications;

      if (notifications[id] !== undefined) {
        Object.keys(notifications[id]).forEach(function(notificationId) {
          try {
            chrome.notifications.clear(notificationId);
          } catch (e) {}
        });

        delete notifications[id];
      }
    }
  },
};

var desktopCaptureSources = Object.keys(
  chrome.desktopCapture.DesktopCaptureSourceType
).reduce(function(sources, key) {
  sources[chrome.desktopCapture.DesktopCaptureSourceType[key]] = key;
  return sources;
}, {});

(function(runtime, desktopCapture, notifications, tabs, chromeWindows) {
  var requestID;

  runtime.onMessageExternal.addListener(onMessageExternal);

  function onMessageExternal(message, sender, respond) {
    switch (message.type) {
      case 'ping':
        respond({
          type: 'pong',
          version: runtime.getManifest().version,
        });
        break;

      case 'getStreamID':
        var sources = message.sources || ['audio', 'screen', 'window', 'tab'];
        // remove source types that are not supported by the platform or browser version.
        // older versions do not support "audio"
        sources = sources.filter(function(source) {
          return source in desktopCaptureSources;
        });

        var tab = sender.tab;
        tab.url = sender.url;

        chooseDesktopMedia(sources, tab)
          .then(onStreamID)
          .catch(onError)
          .then(respond);
        // indicate that this will be async
        return true;

      case 'cancel':
        var id = message.requestID || requestID;
        if (id) {
          desktopCapture.cancelChooseDesktopMedia(id);
          respond({
            type: 'canceled',
            requestID: id,
          });
        } else {
          throw new Error('REQUEST_ID_UNDEFINED');
        }

        break;

      case 'focusTabAndWindow':
        if (sender.tab === undefined) {
          respond({
            type: 'error',
            error: 'MESSAGESENDER_TAB_UNDEFINED',
          });
          return;
        }

        Promise.all([
          updateTab(sender.tab.id, {
            active: true,
          }),
          updateWindow(sender.tab.windowId, {
            focused: true,
          }),
        ])
          .then(function(results) {
            return {
              type: 'focusTabAndWindow',
              tab: results[0],
              window: results[1],
            };
          })
          .catch(respondError)
          .then(respond);

        return true;

      // Returns the active tab from the last window that had focus
      case 'getLastFocusedWindow':
        getLastFocusedWindow(message.getInfo)
          .then(function(window) {
            return {
              type: 'getLastFocusedWindow',
              window: window,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'getTabForSender':
        respond({
          type: 'getTabForSender',
          tab: sender.tab,
        });
        break;

      case 'getTabAndWindowForSender':
        if (sender.tab === undefined) {
          respond({
            type: 'error',
            error: 'MESSAGESENDER_TAB_UNDEFINED',
          });
          return;
        }

        getWindow(sender.tab.windowId, {populate: true})
          .then(function(window) {
            return {
              type: 'getTabAndWindowForSender',
              tab: sender.tab,
              window: window,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'getWindow':
        getWindow(message.windowId, message.getInfo)
          .then(function(window) {
            return {
              type: 'getWindow',
              window: window,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'updateTab':
        updateTab(message.tabId, message.updateProperties)
          .then(function(tab) {
            return {
              type: 'updateTab',
              tab: tab,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'updateWindow':
        updateWindow(message.windowId, message.updateInfo)
          .then(function(window) {
            return {
              type: 'updateWindow',
              window: window,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'clearNotification':
        clearNotification(message.notificationId)
          .then(function(wasCleared) {
            return {
              type: 'clearNotification',
              wasCleared: wasCleared,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'createNotification':
        NotitifcationManager.addNotificationId(sender, message.notificationId);

        createNotification(message.notificationId, message.options)
          .then(function(notificationId) {
            return {
              type: 'createNotification',
              notificationId: notificationId,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'getAllNotifications':
        getAllNotifications()
          .then(function(notifications) {
            return {
              type: 'getAllNotifications',
              notifications: notifications,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'getNotificationsPermissionLevel':
        getNotificationsPermissionLevel()
          .then(function(level) {
            return {
              type: 'getNotificationsPermissionLevel',
              level: level,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;

      case 'updateNotification':
        updateNotification(message.notificationId, message.options)
          .then(function(wasUpdated) {
            return {
              type: 'updateNotification',
              wasUpdated: wasUpdated,
            };
          })
          .catch(respondError)
          .then(respond);
        return true;
    }

    function chooseDesktopMedia(sources, tab) {
      return new Promise(function(resolve, reject) {
        function cb(streamID, options) {
          if (runtime.lastError !== undefined) {
            reject(new Error(runtime.lastError.message));
          } else {
            resolve({
              streamID: streamID,
              options: options,
            });
          }
        }

        try {
          requestID = desktopCapture.chooseDesktopMedia(sources, tab, cb);
        } catch (e) {
          reject(e);
        }
      }).catch(function(err) {
        if (
          //older version of chrome, try again without "tab" option
          err.message.toLowerCase().indexOf('tab capture is not supported') > -1
        ) {
          var filteredSources = sources.filter(function(source) {
            return source !== 'tab';
          });
          return chooseDesktopMedia(filteredSources, tab);
        }

        throw err;
      });
    }

    function onStreamID(result) {
      if (!result.streamID) {
        throw new Error('canceled');
      }

      return {
        type: 'streamID',
        streamID: result.streamID,
        options: result.options,
        requestID: requestID,
      };
    }

    function onError(error) {
      return {
        type: 'canceledGetStreamID',
        error: error,
      };
    }

    function respondError(error) {
      return {
        type: 'error',
        message: error.message,
      };
    }

    function getLastFocusedWindow(getInfo) {
      return new Promise(function(resolve, reject) {
        try {
          chromeWindows.getLastFocused(
            getInfo,
            checkLastError(resolve, reject)
          );
        } catch (e) {
          reject(e);
        }
      });
    }

    function getWindow(windowId, getInfo) {
      return new Promise(function(resolve, reject) {
        try {
          chromeWindows.get(windowId, getInfo, checkLastError(resolve, reject));
        } catch (e) {
          reject(e);
        }
      });
    }

    function updateTab(tabId, updateProperties) {
      return new Promise(function(resolve, reject) {
        try {
          tabs.update(tabId, updateProperties, checkLastError(resolve, reject));
        } catch (e) {
          reject(e);
        }
      });
    }

    function updateWindow(windowId, updateInfo) {
      return new Promise(function(resolve, reject) {
        try {
          chromeWindows.update(
            windowId,
            updateInfo,
            checkLastError(resolve, reject)
          );
        } catch (e) {
          reject(e);
        }
      });
    }

    //notifications

    function clearNotification(notificationId) {
      return new Promise(function(resolve, reject) {
        try {
          notifications.clear(notificationId, checkLastError(resolve, reject));
        } catch (e) {
          reject(e);
        }
      });
    }

    function createNotification(notificationId, options) {
      return new Promise(function(resolve, reject) {
        try {
          notifications.create(
            notificationId,
            options,
            checkLastError(resolve, reject)
          );
        } catch (e) {
          reject(e);
        }
      });
    }

    function getAllNotifications() {
      return new Promise(function(resolve, reject) {
        try {
          notifications.getAll(checkLastError(resolve, reject));
        } catch (e) {
          reject(e);
        }
      });
    }

    function getNotificationsPermissionLevel() {
      return new Promise(function(resolve, reject) {
        try {
          notifications.getPermissionLevel(checkLastError(resolve, reject));
        } catch (e) {
          reject(e);
        }
      });
    }

    function updateNotification(notificationId, options) {
      return new Promise(function(resolve, reject) {
        try {
          notifications.update(
            notificationId,
            options,
            checkLastError(resolve, reject)
          );
        } catch (e) {
          reject(e);
        }
      });
    }

    // helper
    function checkLastError(resolve, reject) {
      return function() {
        if (runtime.lastError !== undefined) {
          reject(new Error(runtime.lastError.message));
        } else {
          resolve.apply(null, arguments);
        }
      };
    }
  }
})(
  chrome.runtime,
  chrome.desktopCapture,
  chrome.notifications,
  chrome.tabs,
  chrome.windows
);

(function(runtime, notifications) {
  function onButtonClicked(port, notificationId, buttonIndex) {
    port.postMessage({
      type: 'notificationButtonClicked',
      notificationId: notificationId,
      buttonIndex: buttonIndex,
    });
  }

  function onClicked(port, notificationId) {
    port.postMessage({
      type: 'notificationClicked',
      notificationId: notificationId,
    });
  }

  function onClosed(port, notificationId, byUser) {
    port.postMessage({
      type: 'notificationClosed',
      notificationId: notificationId,
      byUser: byUser,
    });
  }

  function onConnect(port) {
    if (port.name === 'notifications') {
      var _onButtonClicked = onButtonClicked.bind(null, port);
      var _onClicked = onClicked.bind(null, port);
      var _onClosed = onClosed.bind(null, port);

      notifications.onButtonClicked.addListener(_onButtonClicked);
      notifications.onClicked.addListener(_onClicked);
      notifications.onClosed.addListener(_onClosed);

      port.onDisconnect.addListener(function(port) {
        notifications.onButtonClicked.removeListener(_onButtonClicked);
        notifications.onClicked.removeListener(_onClicked);
        notifications.onClosed.removeListener(_onClosed);
        NotitifcationManager.clearAllNotifications(port.sender);
      });
    }
  }

  runtime.onConnectExternal.addListener(onConnect);
})(chrome.runtime, chrome.notifications);
