require 'json'
require 'base64'
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def show
    @json_document = transform_string(params[:encoded_string]) if params[:encoded_string].present?
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_url = IntegrationService.get_redirect_url(@product)
      return_url = product_url(@product)
      redirect_to "#{redirect_url}?return_url=#{return_url}"
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :amount, :email, :user_name)
    end

    def transform_string(encoded_string)
      decoded_xml = Base64.urlsafe_decode64(encoded_string)
      decoded_hash = Hash.from_xml(decoded_xml).to_json
      decoded_hash = JSON.parse(decoded_hash)["hash"]
    end
end
