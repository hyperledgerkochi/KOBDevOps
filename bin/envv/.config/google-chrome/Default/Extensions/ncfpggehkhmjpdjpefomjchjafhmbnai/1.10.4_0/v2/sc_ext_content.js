/**
 * Copyright 2004-present Facebook. All Rights Reserved.
 *
 * @noformat
 * @haste-ignore
 * @nolint
 */

/**
 * This content script is used to announce plugin availability
 */

(function(html) {
  html.setAttribute('data-fb-only-screensharing-extension-available', true);
})(document.documentElement);
