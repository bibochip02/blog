class CreateMerchantPins < ActiveRecord::Migration[7.1]
  def change
    create_table :merchant_pins do |t|
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
