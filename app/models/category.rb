class Category < ActiveRecord::Base
	has_many :product_categories
	has_many :products, through: :product_categories
	belongs_to :parent, class_name: "Category"
	has_many :children, class_name: "Category", foreign_key: "parent_id"

end
