class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references :variant, index: true
      t.string :code

      t.timestamps null: false
    end
    add_foreign_key :coupons, :variants
  end
end
