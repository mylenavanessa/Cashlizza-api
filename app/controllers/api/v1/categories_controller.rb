class Api::V1::CategoriesController < ApplicationController
  respond_to :json
  
  before_action :set_category, only: [:show, :update, :delete]
  before_action :set_categories, only: [:index]

  def show 
    render json: @category
  end

  def index
    render json: @categories
  end

  def create
    @category = Category.new(api_params)

    respond_to do |format|
      if @category.save
        format.json { render json: @category, status: :created }
      else
        format.json do
          render json: { errors: @category.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(api_params)
        format.json { render json: @category, status: :ok }
      else
        format.json do
          render json: { errors: @category.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @category.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end
end
