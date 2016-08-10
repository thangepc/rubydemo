$(document).ready(function() {
	$('body').on('click','.delete-item', function (e) {
		e.preventDefault();
		var url = $(this).attr('data-url');
		var listTable = $(this).attr('data-list');
		var lblConfirm = $(this).attr('data-confirm');
		if(typeof url !== 'undefined' && lblConfirm != '') {
			var choose = confirm(lblConfirm);
			if(choose) {
				$.ajax({
					type: "POST",
					url: url,
					success: function (result) {
						$('.panel.notice').addClass('hide');
						if(result.status == 1) {
							$(listTable).html(result.html);
							$('.notice-success .panel-body').text(result.message).parents('.notice-success').removeClass('hide').addClass('show');
						} else {
							$('.notice-error .panel-body').text(result.message).parents('.notice-error').removeClass('hide').addClass('show');
						}
					}
				});
			}
		}
	});
	if ($("#upload-files").length) {
		$("#upload-files").fileinput({
			uploadUrl: '/upload_files', // server upload action
			uploadAsync: false,
			showUpload: false,
			showUploadedThumbs: false,
			layoutTemplates: {
			    actionUpload: ''
			},
			maxFileCount: 5,
			uploadExtraData: {authenticity_token: $('#authenticity_token').attr('value')}
		});
	}

	if ($("[name='my-checkbox']").length) {
		$("[name='my-checkbox']").bootstrapSwitch().on('switchChange.bootstrapSwitch', function(event, state) {
			var id = $(this).attr('data-id');
			var url = $(this).attr('data-url');
			if (typeof id !== 'undefined' && typeof url !== 'undefined') {
				$.ajax({
					type: 'POST',
					url: url,
					data: {id: id, status: state == true ? 1 : 0},
					success: function(result) {
						$('.panel.notice').addClass('hide');
						if(result.status == 1) {
							$('.notice-success .panel-body').text(result.message).parents('.notice-success').removeClass('hide').addClass('show');
						} else {
							$('.notice-error .panel-body').text(result.message).parents('.notice-error').removeClass('hide').addClass('show');
						}
					}
				});
			}
		});
	}

	$('body').on('click', '.change-status-order', function(e) {
		e.preventDefault();
		var item = $(this);
		var status = item.attr('data-status');
		var url = item.parents('ul').attr('data-url');
		var id = item.parents('ul').attr('data-id');
		if (typeof status !== 'undefined' && typeof url !== 'undefined' && typeof id !== 'undefined') {
			$.ajax({
				type: "POST",
				url: url,
				data: {id: id, status: status},
				success: function(result) {
					if (result.status == 1) {
						$('#item-button-status-' + id).removeClass(result.listButtonStatus).addClass(result.button).text(result.labelButton);
						$('#item-button-status-toggle-' + id).removeClass(result.listButtonStatus).addClass(result.button);
						object = $('#message-notification-js');
						object.attr('data-title', 'Success').attr('data-type', 'success').html(result.message);
						showNotification(object);
					} else {
						object = $('#message-notification-js');
						object.attr('data-title', 'Error').attr('data-type', 'danger').html(result.message);
						showNotification(object);
					}
				}
			})
		}
	});

	if($('.datepicker').length){
		$('.datepicker').datepicker();
	}
});