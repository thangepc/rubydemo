class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :voice_number
    	t.string :description
    	t.integer :quantity
    	t.float :total
      	t.timestamps null: false
    end
  end
end
