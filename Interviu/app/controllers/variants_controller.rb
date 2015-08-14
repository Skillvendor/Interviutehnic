class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :edit, :update, :destroy]

  # GET /variants
  def index
    @variants = Variant.all
  end

  # GET /variants/1
  def show
  end

  # GET /variants/new
  def new
    @variant = Variant.new
    @ids = Product.pluck(:id)
  end

  # GET /variants/1/edit
  def edit
  end

  # POST /variants
  def create
    @variant = Variant.new(variant_params)

    if @variant.save
      flash[:succes] =  'Variant was successfully created.' 
      redirect_to @variant    
    else
      flash[:danger] = 'Could not create variant'
      render :new 
    end
  end

  # PATCH/PUT /variants/1
  def update
    if @variant.update(variant_params)
      flash[:succes] =  'Variant was successfully updated.' 
      redirect_to @variant
    else
      flash[:danger] = 'Could not update variant'
      render :edit 
    end
  end

  # DELETE /variants/1
  def destroy
    if @variant.destroy
      flash[:succes] =  'Variant was successfully destroyed.' 
      redirect_to variants_url
    else
      flash[:danger] =  'Variant was not destroyed.'
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variant
      @variant = Variant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variant_params
      params.require(:variant).permit(:is_active, :price, :quantity, :product_id)
    end
end
