class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.boolean :fulfilled
      t.decimal :total
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
