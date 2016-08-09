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
				# order.status = params[:status]
				if order.update_column( :status, params[:status])
					flash[:message_success] = ''
					render :json => {status: 1}
					return
				end
			end
		end

	end


end
