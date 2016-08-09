class ClientController < ApplicationController
	include SessionsHelper, ApplicationHelper

	def index
		# images = Attachment.where('id_item = ? AND object = ?', 20, 'product').order(sort: :asc).first
		# render :json => images
		@products = Product.all.page(params[:page]).order(:title)
	end

	def detail
		if params[:id] != nil
			@product = Product.find(params[:id])
		end
	end

	def categories
		if params[:id] != nil
			@category = Category.find(params[:id])
			@productCategory = ProductCategory.where(:category_id => params[:id]).pluck(:product_id)
			@products = Product.where(id: @productCategory).page(params[:page]).order(:title)
			# render :json => @products.inspect
			# return

		end
	end

	def products

		keyQuery = ''
		valueQuery = []
		case params[:type]
			when "name"
				keyQuery += "title"
				if params[:keyword] != nil
					keyQuery += " LIKE ?"
					valueQuery.push("%" + params[:keyword] + "%")
				end
			when "price"
				keyQuery += "price"
				if params[:keyword] != nil
					keyQuery += " = ?"
					valueQuery.push(params[:keyword])
				end
			when "content"
				keyQuery += "content"
				if params[:keyword] != nil
					keyQuery += " LIKE ?"
					valueQuery.push("%" + params[:keyword] + "%")
				end
			else
				keyQuery += "title"
				if params[:keyword] != nil
					keyQuery += " LIKE ?"
					valueQuery.push("%" + params[:keyword] + "%")
				end
			end
		
		orderQuery = 'title ASC'
		if params[:sort] != nil && params[:order] != nil
			orderQuery = params[:sort] + " " + params[:order]
		end

		@products = Product.where(keyQuery, valueQuery).page(params[:page]).order(orderQuery)
		# render :json => orderQuery.inspect
		# return
	end

	def comment
		if request.request_method() == 'POST'
			if params[:product_id]
				@product = Product.find(params[:product_id])

				@product.comments.create(content: params[:content], rate: params[:rate], user_id: session[:client])
				flash[:message_success] = "Add comment is successful"
				redirect_to detail_product_path(@product)
				# @comment = Comment.new(content: params[:content], product_id:)
			end
		end
	end

	def buynow
		if request.request_method() == 'POST'
			# session[:cart] = nil
			session[:cart] ||={}
	        products = session[:cart]["products"]
	        # session[:cart]
	        #If exists, add new, else create new variable
	        if (products && products != {})
	        	flag = 0
	        	session[:cart]['products'].each_with_index do |value, index| 
	        		if params[:product_id] == value
		    			flag = 1
	        			session[:cart]["quantity"][index] += params[:quantity].to_i
	        		end
	        	end
	        	if flag == 0
	        		session[:cart]["products"] << params[:product_id]
			        session[:cart]["quantity"] << params[:quantity].to_i
			    end
	        else
	            session[:cart][:products] = Array(params[:product_id])
	            session[:cart][:quantity] = Array(params[:quantity].to_i)
	        end
	        redirect_to request.referer
		end		
	end

	def cart
		# render :json => session[:cart]
		# return
		# session[:cart]["products"].delete_at(0)
		# session[:cart]["quantity"].delete_at(0)
		cart = session[:cart]
		productId = cart["products"]
		@quantity = cart["quantity"]
		@products ||= []
		if productId != nil
			productId.each_with_index do |id, index|
				product = Product.find(id)
				@products << product
			end
		end
	end

	def update_cart
		products = session[:cart]["products"]
		item_amount = 0
		if (products && products != {})
			products.each_with_index do |value, index| 
        		if params[:product_id] == value
        			session[:cart]["quantity"][index] = params[:quantity].to_i
        			product = Product.find(value)
        			if product != nil
        				price = product.price || 0
        				item_amount = session[:cart]["quantity"][index].to_i * price
        			end
        		end
        	end
		end
		
		@responce = {
			item_amount: convert_number_to_currency(item_amount),
			total_amount: convert_number_to_currency(calculator_total_cart),
			status: 1
		}
		render :json => @responce
		return
	end

	def delete_cart
		if params[:product_id] != nil && session[:cart]["products"] != nil
			session[:cart]["products"].each_with_index do |value, index|
				if value == params[:product_id]
					session[:cart]["products"].delete_at(index)
					session[:cart]["quantity"].delete_at(index)
				end
			end
		end
		@responce = {
			total_product: session[:cart]["products"] != nil ? session[:cart]["products"].count : 0,
			# item_amount: convert_number_to_currency(item_amount),
			total_amount: convert_number_to_currency(calculator_total_cart),
			status: 1
		}
		render :json => @responce
		return
	end


	def calculator_total_cart
		total_amount = 0
		session[:cart]["products"].each_with_index do |value, index|
			product = Product.find(value)
			if product != nil
				price = product.price || 0
				total_amount += session[:cart]["quantity"][index].to_i * price
			end
		end
		total_amount
	end

	def booking
		@totalProduct = session[:cart]["products"].count || 0
		@totalAmount = convert_number_to_currency(calculator_total_cart)

		if request.request_method() == 'POST'

		end
	end


end
