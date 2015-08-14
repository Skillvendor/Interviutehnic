class Product < ActiveRecord::Base
	has_many :variants, dependent: :destroy
	has_many :active_variants, -> { where(is_active: true).order(:price) }, class_name: "Variant"
	validates_presence_of :title
end
