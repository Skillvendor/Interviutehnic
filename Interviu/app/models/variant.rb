class Variant < ActiveRecord::Base
	has_many :coupons
	belongs_to :products
	validates_presence_of :is_active, :price, :quantity
end
