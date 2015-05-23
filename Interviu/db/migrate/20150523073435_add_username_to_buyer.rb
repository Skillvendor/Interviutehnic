class AddUsernameToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :username, :string
    add_index :buyers, :username, unique: true
  end
end
