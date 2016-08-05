class AddFieldIdItemToAttachmentsTable < ActiveRecord::Migration
  def change
  	add_column :attachments, :id_item, :integer
  end
end
