/**
 * Copyright 2004-present Facebook. All Rights Reserved.
 *
 * @noformat
 * @haste-ignore
 * @nolint
 */

/**
 * This background script is used to invoke chrome.desktopCapture API to capture
 * screen media.
 */

var DATA_SOURCES = ['screen', 'window'];
var MESSAGE_RECIPIENT = 'SC_CONTENT_SCRIPT';
var DEBUG = false;

var MESSAGE = {
  CANCEL: 'SC_CANCEL',
  CANCELLED: 'SC_CANCELLED',
  DIALOG_FAIL: 'SC_DIALOG_CANCEL',
  DIALOG_SUCCESS: 'SC_DIALOG_SUCCESS',
  ERROR: 'SC_ERROR',
  INSTALLED: 'SC_EXT_INSTALLED',
  IS_INSTALLED: 'SC_IS_EXT_INSTALLED',
  NOT_SUPPORTED: 'SC_ERROR',
  REQUEST: 'SC_REQUEST',
};

chrome.runtime.onConnect.addListener(onConnect);

function onConnect(port) {
  var requestID;

  log('setup port', port);

  port.onMessage.addListener(onMessage);
  port.onDisconnect.addListener(onDisconnect);

  function onMessage(message) {
    log('onDOMRequest + message', message);

    if (!chrome.desktopCapture) {
      sendMessage(message, MESSAGE.NOT_SUPPORTED);
      return;
    }

    switch (message.type) {
      case MESSAGE.IS_INSTALLED:
        sendMessage(message, MESSAGE.INSTALLED);
        break;

      case MESSAGE.REQUEST:
        cancelRequest();
        requestID = chrome.desktopCapture.chooseDesktopMedia(
          DATA_SOURCES,
          port.sender.tab,
          onDesktopMedia
        );
        break;

      case MESSAGE.CANCEL:
        cancelRequest();
        sendMessage(message, MESSAGE.CANCELLED);
        break;

      default:
        sendMessage(message, MESSAGE.ERROR);
    }

    function onDesktopMedia(streamId) {
      if (streamId) {
        message.streamId = streamId;
        sendMessage(message, MESSAGE.DIALOG_SUCCESS);
      } else {
        sendMessage(message, MESSAGE.DIALOG_FAIL);
      }
    }
  }

  function sendMessage(message, type) {
    log('sendMessage', type);

    message.type = type;
    message.recipient = MESSAGE_RECIPIENT;

    port.postMessage(message);
  }

  function cancelRequest() {
    if (requestID) {
      chrome.desktopCapture.cancelChooseDesktopMedia(requestID);
      requestID = null;
    }
  }

  function onDisconnect() {
    cancelRequest();

    port.onMessage.removeListener(onMessage);
    port.onDisconnect.removeListener(onDisconnect);
  }
}

function log() {
  if (DEBUG) {
    console.log.apply(console, arguments);
  }
}
