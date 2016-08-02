class Category < ActiveRecord::Base
	has_many :product_categories
	has_many :products, through: :product_categories
	belongs_to :parent, class_name: "Category"
	has_many :children, class_name: "Category", foreign_key: "parent_id"
	validates_presence_of :title
	validates_length_of :title ,{:minimum => 2, :maximum => 255}
	validates_uniqueness_of :title

	mount_uploader :image, AttachmentUploader

	self.per_page = 15
end
