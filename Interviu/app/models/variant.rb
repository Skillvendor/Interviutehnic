class Variant < ActiveRecord::Base
	has_many :coupons
	belongs_to :products
end
