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

	
		appendScript('/js/zone/zone.js');
	
		appendScript('/js/jquery/jquery.js');
	
		appendScript('/js/jquery/jquery-ui.min.js');
	
		appendScript('/js/jquery/jquery.ui.autocomplete.html.js');
	
		appendScript('/js/jquery/jquery.cookie.js');
	
		appendScript('/js/jquery/jstree/jquery.jstree.js');
	
		appendScript('/js/jquery/jstree/jquery.jstree.lucidStorage.js');
	
		appendScript('/js/jquery/jquery.filedrop.js');
	
		appendScript('/js/jquery/jquery.lucidtab.js');
	
		appendScript('/js/jquery/fancybox/jquery.fancybox.min.js');
	
		appendScript('/js/jquery/jquery.mousewheel.min.js');
	
		appendScript('/js/jquery/jquery.csv.min.js');
	
		appendScript('/js/jquery/jquery.lucid.redirect.js');
	
		appendScript('/js/json-sans-eval/json-minified.js');
	
		appendScript('/js/xregexp/xregexp-min.js');
	
		appendScript('/js/xregexp/xregexp-unicode-base.js');
	
		appendScript('/js/xregexp/xregexp-unicode-categories.js');
	
		appendScript('/js/box2d/box2d.js');
	
		appendScript('/js/caja/4768/caja.js');
	
		appendScript('/js/plupload/plupload.full.js');
	
		appendScript('/js/clipper.js');
	
		appendScript('/js/app/config/chart.js');
	
		appendScript('/js/earcut.min.js');
	
		appendScript('/js/angular/angular.js');
	
		appendScript('/js/i18n/i18n.js');
	
		appendScript('/js/localforage.min.js');
	
		appendScript('/js/i18n/generated/compiled/ng2chromechart/en.js');
	
		appendScript('/js/tslib.es6.js');
	
		appendScript('/js/angular/es6-shim.js');
	
		appendScript('/js/reflect/Reflect.js');
	
		appendScript('/js/closure/bin/ng2chromechart.js');
	
		appendScript('/js/chromechart/editor.js');
	
		appendScript('/fonts/public.json');
	
})();
