class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_buyer!


  def index
    @display = []
    #@products = Product.all.includes(:active_variants)
    #@products = Product.all
    #@products.each do |product|
    #@children = product.variants.first

    # if @children.present?
    #  @display << {
    #                id: product.id,
    #                title: product.title,
    #                price:  @children.price,
    #                quantity:  @children.quantity,
    #                variant_id:  @children.id
    #             }
    #  end
    #end
     
    #query = "select v.price, v.quantity, p.title, v.product_id from variants v join products p on (v.product_id = p.id) where (v.price,v.product_id) in (select min(price), product_id from variants group by product_id)"
    query = "SELECT min(v.price) AS 'price', v.quantity AS 'quantity', p.title AS 'title', v.id AS 'variant_id' FROM variants AS 'v' INNER JOIN products AS 'p' ON (v.product_id = p.id) GROUP BY product_id" 
    @display = ActiveRecord::Base.connection.execute(query)
    #CUM FRATE sa ITI DEA {"min_price"=>2, "quantity"=>10, "title"=>"Intelligent Plastic Shoes", "product_id"=>600, 0=>2, 1=>10, 2=>"Intelligent Plastic Sh isi bate joc de mine!
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
