$(function() {
    var url = window.chromeApp.url,
        partition = window.chromeApp.partition,
        onWebviewCreate = window.chromeApp.onWebviewCreate;

    var webview = $('<webview id="webview" style="width:100%; height:100%"' + (partition ? ' partition="'+partition+'"' : '') + '></webview>').insertAfter('#status');
    webview.attr('src', url);

    onWebviewCreate && onWebviewCreate(webview);

    $('.back').click(function() {
        webview[0].back();
    });
    $('.forward').click(function() {
        webview[0].forward();
    });
    $('.refresh').click(function() {
        webview[0].reload();
    });
    webview.on('loadcommit', function() {
        $('.back').fadeTo(100, this.canGoBack() ? 1 : .65);
        $('.forward').fadeTo(100, this.canGoForward() ? 1 : .65);
    });

    $('#tryAgain').click(function() {
        webview[0].reload();
        $('#tryAgain').text('Loading.....');
    });

    var okay;
    webview.on('loadabort', function(event) {
        if(!window.url
                && webview[0].src.indexOf(lucidConfigure.lucid_host) == 0
                && (event.originalEvent.reason == 'ERR_NAME_NOT_RESOLVED' || event.originalEvent.reason == 'ERR_INTERNET_DISCONNECTED')) {
            okay = false;
            setTimeout(function() {
                okay = true;
            }, 50);
            $('#needInternet').show();
            setTimeout(function() {
                $('#tryAgain').text('Try again');
            }, 200);
        }
    });

    webview.on('loadstart', function(event) {
        if(event.originalEvent.url.indexOf('mailto:') == 0) { //doesn't work; gives us about:blank
            open(url, '_blank');
        } else if (event.originalEvent.url != 'about:blank') {
            $('#status').text('Loading...');
        }
    });

    webview.on('loadcommit', function() {
        $('#status').text('');
        if(okay) {
            $('#needInternet').fadeOut();
        }
    });

    webview.on('loadstop', function() {
        this.contentWindow.postMessage('hi', '*');
    });

    $(window).on('online', function() {
        if($('#needInternet').is(':visible') && $('#tryAgain').text() == 'Try again') {
            webview[0].reload();
        }
    });
});
