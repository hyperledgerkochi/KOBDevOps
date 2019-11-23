/**
 * This is currently used by the Chrome App to allow AJAX requests against lucidchart.com instead of chrome-extension://
 * params['_local'] prevents this behavior
 *
 * TODO: It may be better to replace this with a common utility method.
 */

$.ajax = (function(ajax) {
    return function(url, params) {
        if(params === undefined) {
            params = url;
            url = params.url;
        }
        if(!params._local) {
            params.url = url.replace(/^\/\//, 'https://').replace(/^\//, lucidConfigure.lucid_host + '/');
        } else {
            delete params._local;
        }
        return ajax.call($, params);
    };
})($.ajax);


$.ajaxSetup({
    statusCode: {
        401: function() {
            (window.chromeApp ? chromeApp.auth : window).refreshToken();
        }
    }
});
