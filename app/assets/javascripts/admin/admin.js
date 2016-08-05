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
});