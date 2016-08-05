class ChangeFieldTypeToTypOnAttachmentTable < ActiveRecord::Migration
  def change
  	rename_column :attachments, :type, :typ
  end
end
