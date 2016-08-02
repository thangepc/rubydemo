class Product < ActiveRecord::Base
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
end
