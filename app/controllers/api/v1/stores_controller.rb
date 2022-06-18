class Api::V1::StoresController < ApplicationController
  respond_to :json
  
  before_action :set_store, only: [:show, :update, :delete]
  before_action :set_stores, only: [:index]

  def show 
    render json: @store
  end

  def index
    render json: @stores
  end

  def create
    @store = Store.new(api_params)

    respond_to do |format|
      if @store.save
        format.json { render json: @store, status: :created }
      else
        format.json do
          render json: { errors: @store.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(api_params)
        format.json { render json: @store, status: :ok }
      else
        format.json do
          render json: { errors: @store.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @store.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @store.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_store
    @store = Store.find(params[:id])
  end

  def set_stores
    filter = params[:filter] || {}
    page = params[:page] ? params[:page].to_i : 1
    limit = 6
    offset = (page.nil? || page == 1 ? 0 : ((page - 1) * limit)).abs

    @stores = QueryFilter.filter_relation(
      ::Store.joins(product_stores: [product: :category, cashbacks: :company]).limit(limit).offset(offset),
      filter
    ).group(:id).select('stores.id, stores.name, stores.logo, stores.description, MAX(cashbacks.percentage) as max_cashback')
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end
end
