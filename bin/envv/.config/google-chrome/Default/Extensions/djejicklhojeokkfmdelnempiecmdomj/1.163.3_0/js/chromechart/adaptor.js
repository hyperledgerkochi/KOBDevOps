// show warning for any calls to unsupported functions
// http://developer.chrome.com/apps/app_deprecated.html

function mask(array, replace) {
    array.forEach(function(name) {
        try {
            var keys = name.split('.'),
                last = keys.pop(),
                obj = keys.reduce(function(self, key) {
                    return self[key];
                }, this);
            obj.__defineGetter__(last, function() {
                console.warn('Getting ' + name);
                return replace(name);
            });
            obj.__defineSetter__(last, function(val) {
                console.warn('Setting ' + name + ':', val);
            });
        } catch (e) {
            console.error('Failed to mask ' + name + ': ' + e);
        }
    });
}

mask([
    'document.cookie',
    'localStorage',
    'onunload',
    'onbeforeunload'
], function(name) {
    return '';
});

mask([
    'alert',
    'confirm',
    'document.close',
    'document.open',
    'document.write',
    'showModalDialog',
], function(name) {
    return function() {
        console.warn.apply(console, ['Called '+name+'with args:'].concat(arguments));
    }
});

var script = null;

// a map of urls to functions that will load plugins
pluginFn = {};
