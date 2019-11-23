/**
 * Copyright 2004-present Facebook. All Rights Reserved.
 *
 * @noformat
 * @haste-ignore
 * @nolint
 */

/**
 * This content script acts as a communication bridge between the DOM and the
 * extension.
 */

var MESSAGE_RECIPIENT = 'SC_DOM';
var SELF = 'SC_CONTENT_SCRIPT';
var DEBUG = false;

var MESSAGE = {
  CANCEL: 'SC_CANCEL',
  IS_EXT_INSTALLED: 'SC_IS_EXT_INSTALLED',
  REQUEST: 'SC_REQUEST',
  RESET_PORT: 'SC_RESET_PORT',
};

connect();

function connect() {
  log('chrome.runtime.id', chrome.runtime.id);

  var port = chrome.runtime.connect(chrome.runtime.id);

  log('setup port', port);

  port.onMessage.addListener(onMessage);
  port.onDisconnect.addListener(restart);

  window.addEventListener('message', parseMessage);

  function parseMessage(event) {
    if (
      event.source !== window ||
      !(event.data && event.data.recipient && event.data.recipient === SELF) ||
      !event.data.type
    ) {
      return;
    }

    switch (event.data.type) {
      case MESSAGE.RESET_PORT:
        log('reset port');

        restart();
        return;

      case MESSAGE.IS_EXT_INSTALLED:
      case MESSAGE.REQUEST:
      case MESSAGE.CANCEL:
        log('forward to extension', event.data);

        port.postMessage(event.data);
        return;

      default:
        log('ignored message type', event.data.type);
    }
  }

  function restart() {
    window.removeEventListener('message', parseMessage);
    port.disconnect();
    connect();
  }
}

function onMessage(message) {
  log('onMessage + message', message);

  message.recipient = MESSAGE_RECIPIENT;

  window.postMessage(message, '*');
}

function log() {
  if (DEBUG) {
    console.log.apply(console, arguments);
  }
}
