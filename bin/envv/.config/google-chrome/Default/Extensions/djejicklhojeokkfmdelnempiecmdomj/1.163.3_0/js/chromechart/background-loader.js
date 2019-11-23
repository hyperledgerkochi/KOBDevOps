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
	
		appendScript('/js/jquery/jquery.lucid.redirect.js');
	
		appendScript('/js/xregexp/xregexp-min.js');
	
		appendScript('/js/xregexp/xregexp-unicode-base.js');
	
		appendScript('/js/xregexp/xregexp-unicode-categories.js');
	
		appendScript('/js/app/config/chart.js');
	
		appendScript('/js/i18n/i18n.js');
	
		appendScript('/js/i18n/generated/compiled/chromechart_background/en.js');
	
		appendScript('/js/closure/bin/chromechart_background.js');
	
		appendScript('/js/plugins/dfd.js');
	
		appendScript('/js/plugins/aws.js');
	
		appendScript('/js/plugins/computation.js');
	
		appendScript('/js/plugins/erd.js');
	
		appendScript('/js/plugins/table.js');
	
		appendScript('/js/plugins/gcp.js');
	
		appendScript('/js/plugins/orgchart.js');
	
		appendScript('/js/plugins/flowchart.js');
	
		appendScript('/js/plugins/ios.js');
	
		appendScript('/js/plugins/freehand.js');
	
		appendScript('/js/plugins/ui.js');
	
		appendScript('/js/plugins/ui2.js');
	
		appendScript('/js/plugins/imagesearch.js');
	
		appendScript('/js/plugins/mindmap.js');
	
		appendScript('/js/plugins/bpmn2.js');
	
		appendScript('/js/plugins/android.js');
	
		appendScript('/js/plugins/rubik.js');
	
		appendScript('/js/plugins/video.js');
	
		appendScript('/js/plugins/floorplan.js');
	
		appendScript('/js/plugins/aws2.js');
	
		appendScript('/js/plugins/uml.js');
	
		appendScript('/js/plugins/serverrack.js');
	
		appendScript('/js/plugins/ee.js');
	
		appendScript('/js/plugins/ios7.js');
	
		appendScript('/js/plugins/timeline.js');
	
		appendScript('/js/plugins/shapes.js');
	
		appendScript('/js/plugins/default.js');
	
		appendScript('/js/plugins/valuestream.js');
	
		appendScript('/js/plugins/equation.js');
	
		appendScript('/js/plugins/bpmn.js');
	
		appendScript('/js/plugins/cisco.js');
	
		appendScript('/js/plugins/ipad.js');
	
		appendScript('/js/plugins/processing.js');
	
		appendScript('/js/plugins/userimage.js');
	
		appendScript('/js/plugins/techclipart.js');
	
		appendScript('/js/plugins/azure.js');
	
		appendScript('/js/plugins/orgchart2.js');
	
		appendScript('/js/plugins/enterprise.js');
	
		appendScript('/js/plugins/network.js');
	
		appendScript('/js/plugins/sitemap.js');
	
		appendScript('/js/plugins/commonshapes.js');
	
		appendScript('/js/plugins/ui3.js');
	
		appendScript('/js/plugins/externalshapes.js');
	
		appendScript('/js/plugins/venn.js');
	
		appendScript('/js/plugins/iphone.js');
	
		appendScript('/js/chromechart/background.js');
	
})();
