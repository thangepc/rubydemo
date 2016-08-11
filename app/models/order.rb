class Order < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper, ApplicationHelper
	require 'securerandom'
	has_many :order_details

	before_save :before_save

	# Validation
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_length_of :first_name ,{:minimum => 2, :maximum => 255}
	validates_length_of :last_name ,{:minimum => 2, :maximum => 255}
	validates_length_of :phone ,{:minimum => 2, :maximum => 255}
	validates_length_of :address ,{:minimum => 2, :maximum => 255}

	def get_amount
		number_to_currency(self.total, precision: 0, locale: I18n.locale)
	end
	def get_quantity
		self.quantity
	end

	# Callback
	def before_save
		# totalQuantity = 0
		# totalAmount = 0
		# if session[:cart]["products"] != nil
		# 	session[:cart]["products"].each_with_index do |value, index|
		# 		product = Product.find(value)
		# 		if !product.nil?
		# 			totalQuantity += session[:cart]["quantity"][index].to_i
		# 			totalAmount += session[:cart]["quantity"][index].to_i * product.price
		# 		end
		# 	end
		# end
		# self.quantity = totalQuantity
		# self.total = totalAmount
		self.invoice_number = SecureRandom.hex
		self.status = 'pending'
	end

	def get_button_status
		color = 'btn-default'
		case self.status
		when 'pending'
		  color = 'btn-danger'
		when 'shipping'
		  color = 'btn-warning'
		when 'recived'
		  color = 'btn-info'
		when 'complete'
		  color = 'btn-success'
		else
		  color = 'btn-default'
		end
		color
	end

	def self.get_list_button_status
		listButtonStatus = ['btn-default', 'btn-danger', 'btn-warning', 'btn-info', 'btn-success']
	end

	def get_list_status
		listStatus = ['pending', 'shipping', 'recived', 'complete', 'cancel']
	end

	def get_button_html
		html = ""
		get_list_status.each do |item|
			text = item.capitalize
			itemList = "<li><a class='change-status-order' href='#'' data-status='#{item}''>#{text}</a></li>"
			html += itemList
		end
		html
	end



end
