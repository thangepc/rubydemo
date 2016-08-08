$(document).ready(function(){
	$('body').on('click', ".sort-order", function(e) {
		e.preventDefault();
		var sort = $(this).attr('data-sort');
		var order = $(this).attr('data-order');
		$('#frmSearch input[name="sort"]').val(sort);
		$('#frmSearch input[name="order"]').val(order);
		$('#frmSearch').submit();
	});
});