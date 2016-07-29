class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :title
    	t.string :model
    	t.float :price
    	t.string :image
    	t.text :description
    	t.text :content
      	t.timestamps null: false
    end
  end
end
