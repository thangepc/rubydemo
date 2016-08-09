class ChangFieldVoiceNumberToInvoiceNumberToOrderTable < ActiveRecord::Migration
  def change
  	rename_column :orders, :voice_number, :invoice_number
  end
end
