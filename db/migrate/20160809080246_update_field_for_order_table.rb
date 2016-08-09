class UpdateFieldForOrderTable < ActiveRecord::Migration
  def change
  	add_column :orders, :first_name, :string
  	add_column :orders, :last_name, :string
  	add_column :orders, :email, :string
  	add_column :orders, :address, :string
  	add_column :orders, :phone, :string
  	add_column :orders, :content, :text
  	add_column :orders, :status, :string
  end
end
