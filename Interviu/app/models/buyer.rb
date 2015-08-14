class Buyer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false }

  validates :email, presence: true,
                       uniqueness: { case_sensitive: false }


  def self.buy(user,variant)
		transaction do
		  new_amount = user.credits - variant.price
		  user.update_attributes!(:credits => new_amount)

		  if variant.quantity == 1
        variant.update_attributes(:is_active => false)
      end

		  Variant.decrement_counter(:quantity, variant.id)
	    variant.save!
	    variant.coupons.create!(code: SecureRandom.hex(20))
		end
	end
end
