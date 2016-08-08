$(document).ready(function(){
	$('body').on('click', ".sort-order", function(e) {
		e.preventDefault();
		var sort = $(this).attr('data-sort');
		var order = $(this).attr('data-order');
		$('#frmSearch input[name="sort"]').val(sort);
		$('#frmSearch input[name="order"]').val(order);
		$('#frmSearch').submit();
	});
	var messageNotification = $('#message-notification');
	if (messageNotification.length) {

		$.notify({
			title: messageNotification.attr('data-title'),
			message: messageNotification.html()},{
			type: messageNotification.attr('data-type'),
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

	$('body').on('click','#btn-show-comment', function(e) {
		e.preventDefault();
		$('#frmComment').removeClass('hide').addClass('show');	
	});
	$('body').on('click','#close-form-comment', function(e) {
		e.preventDefault();
		$('#frmComment').removeClass('show').addClass('hide');
	});

	$('#frmComment').validator();
});