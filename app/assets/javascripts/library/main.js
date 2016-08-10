function showNotification(object) {
	var messageNotification = object;
	if (messageNotification.length) {
		// console.log(messageNotification.attr('data-title'));
		$.notify ({
			title: messageNotification.attr('data-title') ? messageNotification.attr('data-title') : 'Message', 
			message: messageNotification.html() ? messageNotification.html() : 'Are you sure?'},{
			type: messageNotification.attr('data-type') ? messageNotification.attr('data-type') : 'success',
			animate: {
				enter: 'animated fadeInDown',
				exit: 'animated fadeOutUp'
			},
			placement: {
				from: "top",
				align: "right"
			},
			template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
			'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
			'<span data-notify="icon"></span> ' +
			'<span data-notify="title">{1}</span> ' +
			'<span data-notify="message">{2}</span>' +
			'<div class="progress" data-notify="progressbar">' +
				'<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
			'</div>' +
			'<a href="{3}" target="{4}" data-notify="url"></a>' +
			'</div>' 
		});
	}
}