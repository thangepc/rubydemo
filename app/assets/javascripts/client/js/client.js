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


	$('body').on('keyup', '.cart-quantity', function(e) {
        // e.defaultPrevented();
        var quantity = $(this).val();
        quantity = parseInt(quantity) || 1;
        var productId = $(this).attr('data-product-id');
        var url = $(this).attr('data-url');
        var amountItem = $(this).attr('data-update-amount');
        var totalAmount = $(this).attr('data-update-total-amount');
            console.log(productId);
        if(typeof quantity !== 'undefined' && typeof productId !== 'undefined' && typeof url !== 'undefined') {
            $.ajax({
                type: "POST",
                url: url,
                data: {quantity: quantity, product_id: productId},
                success: function(result) {
                    if (result.status == 1) {
                        $(amountItem).html(result.item_amount);
                        $(totalAmount).html(result.total_amount);
                    }
                }
            });
        }
    });

    $('body').on('click', '.delete-cart', function (e) {
        e.preventDefault();
        var item = $(this);
        bootbox.confirm("Ban co chac chan muon xoa san pham nay?", function(result) {
            if (result) {
                var productId = item.attr('data-product-id');
                var url = item.attr('data-url');
                var totalAmount = item.attr('data-update-total-amount');
                if (typeof productId !== 'undefined' && typeof url !== 'undefined') {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: {product_id: productId},
                        success: function(result) {
                            if (result.status == 1) {
                                item.parents('tr').remove();
                                $(totalAmount).html(result.total_amount);
                                $('#label-header-cart').text(result.total_product);
                                if (result.total_product == 0) {
                                    $('#list-cart tbody tr').remove();
                                    $('#list-cart tfoot').remove();
                                    $('#list-cart tbody').append('<tr><td colspan="7">Khong co san pham nao trong gio hang</td></tr>');
                                }
                            }
                        }
                    });
                }
                
            }
        });
    });
});