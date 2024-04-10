class AddContactToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :contact, :string
    remove_column :users, :address, :string
  end
end
