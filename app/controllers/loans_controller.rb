class LoansController < ApplicationController
  before_action :load_loan, only: [:show]

  def create
    @loan = Loan.new(loans_params)
    @loan.pmt
    @loan.save!

    render json: { id: @loan.id, pmt: @loan.pmt } if @loan.persisted?
  rescue StandardError
    render json: { errors: { message: @loan.errors.full_messages } }, status: :unprocessable_entity
  end

  def show
    # pmt =  3_700 / 12
    # @loan = Loan.find(params[:id])
    if @loan.nil?
      render json: { error: :not_found, status: 400 }
    else
      render json: { loan: @loan.to_app }
    end
  end

  private

  def loans_params
    params.permit(%i[value rate months])
  end

  def load_loan
    @loan = Loan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
