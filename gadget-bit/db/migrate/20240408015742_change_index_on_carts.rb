class ChangeIndexOnCarts < ActiveRecord::Migration[7.1]
  def change
    remove_index :carts, name: "index_carts_on_user_id"
    add_index :carts, :user_id
  end
end
