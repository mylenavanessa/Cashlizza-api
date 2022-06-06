class Api::V1::CompaniesController < ApplicationController
  respond_to :json
  
  before_action :set_company, only: [:show, :update, :delete]
  before_action :set_companies, only: [:index]

  def show 
    render json: @company
  end

  def index
    render json: @companies
  end

  def create
    @company = Company.new(api_params)

    respond_to do |format|
      if @company.save
        format.json { render json: @company, status: :created }
      else
        format.json do
          render json: { errors: @company.errors.full_messages } , status: 403
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(api_params)
        format.json { render json: @company, status: :ok }
      else
        format.json do
          render json: { errors: @company.errors.full_messages }, status: 403
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @company.destroy
        format.json { render json: nil, status: :ok }
      else
        format.json do
          render json: { errors: @company.errors.full_messages }, status: 403
        end
      end
    end
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def set_companies
    @companies = Company.all
  end

  def api_params
    params_list = [:name]

    params.permit(params_list)
  end
end
