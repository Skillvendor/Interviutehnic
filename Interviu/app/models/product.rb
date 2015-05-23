class Product < ActiveRecord::Base
	has_many :variants, dependent: :destroy
	validates_presence_of :title
end
