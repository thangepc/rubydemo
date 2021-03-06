module ApplicationHelper
	include ActionView::Helpers::NumberHelper
	def full_title(page_title = '')
	    base_title = "Ruby on Rails Tutorial Sample App"
	    if page_title.empty?
	      	base_title
	    else
	      	page_title + " | " + base_title
	    end
	end

	def trim(string = '', length)
		defaultString = '...'
	    if string == nil || string.empty?
	      	defaultString
	    else
	    	if length == nil
	    		string
	    	elsif length != nil && string.length < length
	    		string
	    	else 
	    		string.truncate(length, separator: ' ')
	    	end
	    end
	end

	def get_image(image)
		defaultImage = 'http://placehold.it/320x150'
		if image.empty?
			defaultImage
		else
			ActionController::Base.relative_url_root.to_s + image
		end
	end


  	def upload_files (files, item, object)
  		mode = "wb"
		upload_path = "#{Rails.root}/public/uploads/" + object
		Dir.mkdir(upload_path) unless File.exists?(upload_path)
		FileUtils.chmod 0755, upload_path
		sort = 1
		files.each { |file|

			if item != nil
				filename = item.id.to_s + "_" + file.original_filename
			else
				filename = file.original_filename
			end
			fileUpload = upload_path + "/" + filename
			File.open(fileUpload, mode) do |item|
		      item.write(file.read)
		    end
			# contentType = MIME::Types.type_for(fileUpload).first.content_type
		    if item != nil
				data = fileUpload.gsub("#{Rails.root}/public/","/")
		    	Attachment.create(id_item: item.id,name: filename, object: object, typ: 'image', data: data, sort: sort)
		    end
		    sort += 1
		}
  	end

  	def convert_number_to_currency(number)
  		if number == nil
			number = 0
		end
		number_to_currency(number, precision: 0, locale: I18n.locale)
  	end

  	def get_total_quantity_and_amount
  		totalQuantity = 0
		totalAmount = 0
		if session[:cart]["products"] != nil
			session[:cart]["products"].each_with_index do |value, index|
				product = Product.find(value)
				if !product.nil?
					totalQuantity += session[:cart]["quantity"][index].to_i
					totalAmount += session[:cart]["quantity"][index].to_i * product.price
				end
			end
		end
		return {quantity: totalQuantity, amount: totalAmount}
  	end

  	def get_total_cart
  		totalItems = 0
  		if session[:cart] != nil
  			totalItems = session[:cart]["products"].count
  		end
  		totalItems
  	end
end

