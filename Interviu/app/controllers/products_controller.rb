class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_buyer!

  # GET /products
  # GET /products.json
  def index

    @products = Product.all
    @display = []
    @products.each do |product|
      @children = product.variants.where(is_active: true).order(:price).first
      if @children.present?
      @display << {
                    id: product.id,
                    title: product.title,
                    description: product.description,
                    price:  @children.price,
                    quantity:  @children.quantity,
                    variant_id:  @children.id
                  }
      end
    end

    @display = Kaminari.paginate_array(@display).page(params[:page])

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
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
