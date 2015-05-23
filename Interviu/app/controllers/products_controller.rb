class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_buyer!


  def index
    @display = []

    query = "SELECT min(v.price) AS 'price', v.quantity AS 'quantity', p.title AS 'title', v.id AS 'variant_id' 
             FROM variants AS 'v' INNER JOIN products AS 'p' ON (v.product_id = p.id) 
             where v.is_active = 't' 
             GROUP BY product_id" 
    
    @display = ActiveRecord::Base.connection.execute(query)
    @display = Kaminari.paginate_array(@display).page(params[:page])  
  end



  def buy
   @user = current_buyer
   @variant = Variant.find_by_id(params[:id])
   if @user.credits > @variant.price 
      @user.credits -= @variant.price
      @user.save!
      @variant.quantity -= 1
      if @variant.quantity == 0
        @variant.is_active = false
      end
      @variant.save!
      flash[:succes] = " Bought!"
      @variant.coupons.create(code: SecureRandom.hex(20))
   else
    flash[:danger] = "Money Money"
   end
   redirect_to :back

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description)
    end
end
