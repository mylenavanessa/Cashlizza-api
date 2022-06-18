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
    filter = params[:filter] || {}
    page = params[:page] ? params[:page].to_i : 1
    limit = 15
    offset = (page.nil? || page == 1 ? 0 : ((page - 1) * limit)).abs

    @products = QueryFilter.filter_relation(
      ::Product.joins(:brand, :category, product_stores: [:store, cashbacks: :company]).limit(limit).offset(offset),
      filter
    ).select('products.id, products.name, categories.name as category_name, brands.name as brand_name, 
              stores.name as store_name, stores.logo as store_logo, companies.name as company_name, 
              companies.logo as company_logo, cashbacks.url, cashbacks.percentage, product_stores.price')
  end

  def api_params
    params_list = [:name, :filter]

    params.permit(params_list)
  end
end
