class AddFieldStatusToAdminTable < ActiveRecord::Migration
  def change
  	add_column :admins, :status, :integer
  end
end
