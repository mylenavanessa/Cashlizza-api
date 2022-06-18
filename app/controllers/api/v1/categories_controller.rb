class Api::V1::CategoriesController < ApplicationController
  respond_to :json
  
  before_action :set_category, only: [:show]
  before_action :set_categories, only: [:index]

  def show 
    respond_to { |format| format.json { render json: @category, status: 200 } }
  end

  def index
    respond_to { |format| format.json { render json: @categories, status: 200 } }
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    filter = params[:filter] || {}
    page = params[:page] ? params[:page].to_i : 1
    limit = 6
    offset = (page.nil? || page == 1 ? 0 : ((page - 1) * limit)).abs

    unless filter.blank?
      @categories = QueryFilter.filter_relation(
        ::Category.joins(products: {product_stores: [:store, cashbacks: :company]}).limit(limit).offset(offset),
        filter
      ).group(:id).select('categories.id, categories.name, MAX(cashbacks.percentage) as max_cashback')

    else
      @categories = Category.select(:id, :name)
    end

  end
end
