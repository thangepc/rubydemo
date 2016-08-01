$(document).ready(function() {
	var authenticity_token = $('#authenticity_token').attr('value');
	$.ajaxSetup({
		data: {
			authenticity_token: authenticity_token,
		}
	});
	$('body').on('click','.delete-item', function (e) {
		e.preventDefault();
		var url = $(this).attr('data-url');
		if(typeof url !== 'undefined') {
			var choose = confirm('Are you sure?');
			if(choose) {
				$.ajax({
					type: "POST",
					url: url,
					success: function (result) {
						console.log(result)
					}
				});
			}
		}
	});
});