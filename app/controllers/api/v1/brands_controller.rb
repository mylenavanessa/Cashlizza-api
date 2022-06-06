class Api::V1::BrandsController < ApplicationController
  respond_to :json
  
  before_action :set_brand, only: [:show, :update, :delete]
  before_action :set_brands, only: [:index]

  def show 
    render json: @brand
  end

  def index
    render json: @brands
  end

  def create
    @brand = Brand.new(api_params)

    respond_to do |format|
      if @brand.save
        format.json { render json: @brand, status: :created }
      else
        format.json do
          render json: { errors: @brand.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @brand.update(api_params)
        format.json { render json: @brand, status: :ok }
      else
        format.json do
          render json: { errors: @brand.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @brand.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @brand.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def set_brands
    @brands = Brand.all
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end

end
