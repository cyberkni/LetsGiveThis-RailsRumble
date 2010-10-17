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

	// validation
	$('#gift_event_edit')
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

	// validation
	$('#new_contribution')
		.validate({
			rules: {
				'contribution[name]': 'required',
				'contribution[amount]': 'required',
				'contribution[email]': {
					required: true,
					email: true
				}
			}
		});

}