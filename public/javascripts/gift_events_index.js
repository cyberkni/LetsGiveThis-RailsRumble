function handler() {

	//
	// init forms
	//

	// new gift
	$('#gift_event_new')

		// collapsed section
		.find('#gift_event_continue')
			.removeClass('hidden')
			.click(function() {
				$(this)
					.hide()
					.parent().parent().find('div.more').fadeIn(300, function(){
						$('#gift_event_gift_title').focus();
					});
			})
		.end()
		.find('div.more').hide().end()

		// validation
		.validate({
			rules: {
				'gift_event[gift_title]': 'required',
				'gift_event[gift_name]': 'required',
				'gift_event[gift_price]': 'required',
				'gift_event[gift_admin_name]': {
					required: true,
					minlength: 2
				},
				'gift_event[gift_admin_email]': {
					required: true,
					email: true
				}
			}
		});

	// administer existing gift
	$('#admin_recovery')

		// validation
		.validate({
			rules: {
				'admin_email': {
					required: true,
					email: true
				}
			}
		});

}

// [EOF]