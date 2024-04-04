class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision:8, scale:2
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
