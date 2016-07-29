class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :title
    	t.string :image
    	t.text :description
    	t.integer :parent_id
    	t.integer :sort_order
      t.timestamps null: false
    end
  end
end
