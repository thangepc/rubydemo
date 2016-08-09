class OrderDetail < ActiveRecord::Base
	belongs_to :order
	has_many :products
end
