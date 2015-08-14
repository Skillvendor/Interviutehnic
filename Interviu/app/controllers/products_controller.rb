class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_buyer!


  def index
    @display = []
    @products = Product.includes(:variants).where("variants.is_active" => true).order("variants.price")

    @products.each do |product|
      @children = product.variants.first
      if @children.present?
        @display << {
                      id: product.id,
                      title: product.title,
                      price:  @children.price,
                      quantity:  @children.quantity,
                      variant_id:  @children.id
                    }
      end
    end
    @display = Kaminari.paginate_array(@display).page(params[:page])  
  end



  def buy
    @user = current_buyer
    @variant = Variant.find_by_id(params[:id])

    unless @user.credits > @variant.price
      flash[:danger] = "You don't have enough money"
      redirect_to :back
    end

    unless Buyer.buy(@user,@variant)
      flash[:danger] = "Couldn't process your request, try again later"
      redirect_to :back
    end

    flash[:succes] = "Thank you for your purchase"
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
