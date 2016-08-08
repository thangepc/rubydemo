class Product < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper, ApplicationHelper
	# RelationShip
	has_many :product_categories
	has_many :categories, through: :product_categories

	# Validation
	validates_presence_of :title
	validates_length_of :title ,{:minimum => 2, :maximum => 255}
	validates_uniqueness_of :title

	mount_uploader :image, AttachmentUploader

	# Pagination
	self.per_page = 15

	def get_image_default
		image = Attachment.where('id_item = ? AND object = ?', self.id, 'product').order(sort: :asc).first
		if image != nil
			image.data
		else
			'http://placehold.it/320x150'
		end
	end

	def get_price
		if self.price == nil
			self.price = 0
		end
		number_to_currency(self.price, precision: 0, unit: "d")
	end

	def get_description(limit = nil)
		trim(self.description, limit)
	end

	def get_title(limit)
		trim(self.title, limit)
	end
end
