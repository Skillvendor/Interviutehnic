class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.boolean :is_active
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
