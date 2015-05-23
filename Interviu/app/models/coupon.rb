class Coupon < ActiveRecord::Base
  belongs_to :variant
  alphanum =  /([A-Za-z0-9]+)/
  validates :code, presence: true, format: {with: alphanum}
end
