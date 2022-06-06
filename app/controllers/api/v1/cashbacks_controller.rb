class Api::V1::CashbacksController < ApplicationController
  respond_to :json
  
  before_action :set_cashback, only: [:show, :update, :delete]
  before_action :set_cashbacks, only: [:index]

  def show 
    render json: @cashback
  end

  def index
    render json: @cashbacks
  end

  def create
    @cashback = Cashback.new(api_params)

    respond_to do |format|
      if @cashback.save
        format.json { render json: @cashback, status: :created }
      else
        format.json do
          render json: { errors: @cashback.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @cashback.update(api_params)
        format.json { render json: @cashback, status: :ok }
      else
        format.json do
          render json: { errors: @cashback.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @cashback.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @cashback.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_cashback
    @cashback = Cashback.find(params[:id])
  end

  def set_cashbacks
    @cashbacks = Cashback.all
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end
end
