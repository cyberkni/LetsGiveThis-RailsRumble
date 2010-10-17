function handler() {

	//
	// init progress bar
	//

	var pb = $("#progressbar");
	pb
		.progressbar({value: parseFloat(pb.attr('title'))})
		.removeClass('hidden');

	//
	// init form
	//

	$('#gift_event_edit')

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

}