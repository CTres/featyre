(function ($) {
	$(document).on('load change keydown keypress input', 'div[data-placeholder]', function() {
		if (this.text) {
			this.setAttribute('data-div-placeholder-content', 'true');
		}
		else {
			this.removeAttribute('data-div-placeholder-content');
		}
	});
})(jQuery);