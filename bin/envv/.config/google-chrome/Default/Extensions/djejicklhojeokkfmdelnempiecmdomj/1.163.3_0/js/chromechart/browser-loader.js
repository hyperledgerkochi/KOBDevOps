// Chrome App bug: script.async = false; doesn't work.
// So we have to wait until the script is done loading
(function() {
	var loading = false;
	var newUrls = true;
	/** @const {!Array{!Array{string}}} */
	var urls = [];

	var MODULE_LOAD_REGEX = /goog\.retrieveAndExec_\("(.*)",\s*true,\s*false\)/;

	function appendScript(url, opt_sourceText) {
		if (!url && opt_sourceText) {
			var match = MODULE_LOAD_REGEX.exec(opt_sourceText);

			if (match) {
				url = match[1];
			}
		}

		if(newUrls) {
			urls.unshift([url]);
			newUrls = false;
			setTimeout(function() {
				newUrls = true;
			}, 0);

			if(!loading) {
				loading = true;
				(function next() {
					var myUrls = urls[0];
					var url = myUrls[0];
					var script = document.createElement('script');
					script.src = url;
					script.async = false;
                    script.charset = "UTF-8";
					script.onload = script.onerror = function() {
						myUrls.shift();
						while(urls.length && !urls[0].length) {
							urls.shift();
						}
						if(urls.length) {
							next();
						} else {
							loading = false;
						}
					};
					document.head.appendChild(script);
				})();
			}
		} else {
			urls[0].push(url);
		}
		return true;
	}

	window.CLOSURE_NO_DEPS = true;
	window.CLOSURE_IMPORT_SCRIPT = appendScript;
	window.CLOSURE_UNCOMPILED_DEFINES = {
		'goog.json.USE_NATIVE_JSON': true,
        'goog.NEVER_TRANSPILE': true,
        'goog.defineClass.SEAL_CLASS_INSTANCES': false
	};

	
		appendScript('/js/jquery/jquery.min.js');
	
		appendScript('/js/jquery/jquery.lucid.redirect.js');
	
		appendScript('/js/chromechart/browser.js');
	
})();
