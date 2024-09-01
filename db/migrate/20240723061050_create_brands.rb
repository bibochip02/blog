class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
