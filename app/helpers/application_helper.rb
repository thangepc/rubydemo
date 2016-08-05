module ApplicationHelper
	def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
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

  	def delete_file

  	end
end
