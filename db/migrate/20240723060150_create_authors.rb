class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :body
      t.integer :article_id

      t.timestamps
    end
  end
end
