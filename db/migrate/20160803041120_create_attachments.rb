class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.string :name
    	t.string :object
    	t.string :type
    	t.string :data
      	t.timestamps null: false
    end
  end
end
