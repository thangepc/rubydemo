class ClientController < ApplicationController
	include SessionsHelper

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
			session[:cart] ||={}
	        products = session[:cart][:products]

	        #If exists, add new, else create new variable
	        if (products && products != {})
	            session[:cart][:products] << params[:product_id]
	        else
	            session[:cart][:products] = Array(params[:product_id])
	        end
	        render :json => session[:cart]
	        return
		end		
	end

	def cart
		@items = cart_contents
	end

end
