class SettingsController < ApplicationController
	def change_locale
	    l = params[:locale].to_s.strip.to_sym
	    l = I18n.default_locale unless I18n.available_locales.include?(l)
	    cookies.permanent[:educator_locale] = l
	    redirect_to request.referer || root_url
	end

	def upload_files
		@files = params[:files]
		
		# @files.each do |file|
		# end
		filename = 'abc.jpg'
		mode = "wb"
		upload_path = "#{Rails.root}/public/uploadss"
		Dir.mkdir(upload_path) unless File.exists?(upload_path)
		FileUtils.chmod 0755, upload_path

		@files.each { |file|
			filename = file.original_filename
			File.open(upload_path + "/" + filename, mode) do |item|
		      item.write(file.read)
		    end
		}




	    @response = {
	        jsonrpc: "2.0",
	        result: "OK",
	        id: "id"
	    }

	    render :json => @response


		# render plain: @files['original_filename'].inspect
		# debug (@files)
		# return false
			# @response = {
		         
		 #    }
		 #    render :json => @response
		# Rails.logger.debug("Person attributes hash A: #{@files}")
	end
	def upload_files2
		@files = params[:files]
		# @files.each do |file|
		# end
		filename = 'abc.jpg'
		mode = "wb"
		upload_path = "#{Rails.root}/public"

		File.open(upload_path + "/" + filename, mode) do |file|
	      file.write(@files.read)
	    end

	    @response = {
	        jsonrpc: "2.0",
	        result: "OK",
	        id: "id"
	    }

	    render :json => @response


		# render plain: @files['original_filename'].inspect
		# debug (@files)
		# return false
			# @response = {
		         
		 #    }
		 #    render :json => @response
		# Rails.logger.debug("Person attributes hash A: #{@files}")
	end

	def delete_file
		key = params[:key]
		image = Attachment.find_by(id: key)
		image.destroy
		@response = {
	        jsonrpc: "2.0",
	        result: "OK",
	        id: image
	    }
		render :json => @response
	end

	def files_sort
		sorts = params[:sort]
		sorts.each { |key,sort|
			image = Attachment.find_by(id: sort)
			image.sort = key
			image.save
			# render :text => sort.inspect
			# return
		}

		@response = {
	        jsonrpc: "2.0",
	        result: "OK",
	        id: sorts
	    }
		render :json => @response
		# return
	end
end
