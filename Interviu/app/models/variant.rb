class Variant < ActiveRecord::Base
	has_many :coupons
	belongs_to :products
	validates_presence_of :price, :quantity, :product_id
end
