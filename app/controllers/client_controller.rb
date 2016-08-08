class ClientController < ApplicationController

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

end
