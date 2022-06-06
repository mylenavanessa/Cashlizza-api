class Api::V1::ProductsController < ApplicationController
  respond_to :json
  
  before_action :set_product, only: [:show, :update, :delete]
  before_action :set_products, only: [:index]

  def show 
    render json: @product
  end

  def index
    render json: @products
  end

  def create
    @product = Product.new(api_params)

    respond_to do |format|
      if @product.save
        format.json { render json: @product, status: :created }
      else
        format.json do
          render json: { errors: @product.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(api_params)
        format.json { render json: @product, status: :ok }
      else
        format.json do
          render json: { errors: @product.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @product.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_products
    @products = Product.all
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end
end
