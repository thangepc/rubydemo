class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
    	t.belongs_to :product
    	t.belongs_to :category
      	t.timestamps null: false
    end
  end
end
