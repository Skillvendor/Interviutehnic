class SetDefaultVariants < ActiveRecord::Migration
  def self.up
    change_column :variants, :is_active, :boolean, :default => true
    change_column :variants, :price, :integer, :default => 0
    change_column :variants, :quantity, :integer, :default => 0
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
