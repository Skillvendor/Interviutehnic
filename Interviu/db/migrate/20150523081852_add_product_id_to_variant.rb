class AddProductIdToVariant < ActiveRecord::Migration
  def change
    add_reference :variants, :product, index: true
    add_foreign_key :variants, :products
  end
end
