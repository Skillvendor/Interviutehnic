class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :variants, :product_id
  end
end
