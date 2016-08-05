class AddFieldSortToAttachmentsTable < ActiveRecord::Migration
  def change
  	add_column :attachments, :sort, :integer
  end
end
