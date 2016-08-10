class OrdersController < ApplicationController
	layout "admin"
	def index
		@active = 'orders'
		@orders = Order.all.page(params[:page]).order(:created_at)
	end

	def change_status
		if params[:id] != nil
			order = Order.find(params[:id])
			if !order.nil?
				if order.status == 'complete'
					render :json => {status: 0, message: "Order is completed. So Don't change status for this order."}
					return
				else
					# order.status = params[:status]
					if order.update_column( :status, params[:status])
						# flash[:message_success] = ''
						labelButton = params[:status].capitalize
						button = order.get_button_status
						listButtonStatus = Order.get_list_button_status.join(' ')
						render :json => {status: 1, message: "Update status order is successful.", button: button, labelButton: labelButton, listButtonStatus: listButtonStatus}
						return
					end
				end
			end
		end

	end


end
