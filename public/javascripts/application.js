/**
 * Common entry point
 * Wait for DOM to load
 */
$(document).ready(function() {

	/*
	 * Add existence handler to jQuery
	 */
	$.fn.exists = function() {
		return this.is('*');
	};

	/*
	 * Add forEach method
	 */
	if (!Array.prototype.forEach) {
		Array.prototype.forEach = function(fn /*, _this*/) {
			var len = this.length >>> 0;
			if (typeof fn != 'function') {
				throw new TypeError();
			}
			var _this = arguments[1];
			for (var i = 0; i < len; i++) {
				if (i in this) {
					fn.call(_this, this[i], i, this);
				}
			}
		};
	}

	/*
	 * Init jQuery Validation plugin
	 */
	$.validator.setDefaults({
		debug: false,
		focusInvalid: true,
		focusCleanup: false,
		errorElement: 'span',
		errorPlacement: function(error, element) {
			// don't show error messages
			return true;
		}
	});

	/*
	 * Remove 'px' suffix and convert string to integer
	 */
	if (!String.prototype.pxToInt) {
		String.prototype.pxToInt = function() {
			return parseInt(this.substr(0, this.lastIndexOf('px'))) || 0;
		};
	}

 	// Initialise typeface.js early to avoid flickering
	_typeface_js.initialize();

	// Warn about crimes against humanity
	if ($.browser.msie && $.browser.version <= 7) {
		var notice, error = 
			'<p class="error">' +
				'You appear to be using an outdated version of Internet Explorer.<br />' +
				'Please visit <a href="http://update.microsoft.com/" rel="external force die">Microsoft Update</a> to upgrade your browser.<br />' +
				'<span class="smallprint">Current version: ' + $.browser.version + '</span>' +
			'</p>';
		if ((notice = $('div.notice')).exists()) {
			notice.prepend(error);
		} else {
			$('body').prepend('<div class="notice">' + error + '</div>');
		}
	}

	// Fix IE 6 flickering bug by forcing caching of background images
	// Based on recommendation from http://support.microsoft.com/kb/823727/
	if ($.browser.msie && $.browser.version == 6) {
		try {
			document.execCommand('BackgroundImageCache', false, true);
		} catch(ex) { /* swallow errors */ }
	}

	// Simulate :focus and :blur on form elements in IE
	if ($.browser.msie) {
		$('input, select, textarea')
			.bind('focus', function() {
				$(this).addClass('focus');
			})
			.bind('blur', function() {
				$(this).removeClass('focus');
			})
	}

	// Animate notices
	$('#notice')
		.hide()
		.slideDown(400);
/*
		.slideDown(400, function() {
			setTimeout(function() {
				$('#notice').slideUp(400, function() {
					$(this).remove();
				});
			}, 10000)
		});
*/

	// Call local handler
	if (typeof(handler) != 'undefined' && handler && typeof(handler) == 'function') {
		handler.call(this);
	}

});