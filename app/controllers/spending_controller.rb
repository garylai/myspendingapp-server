class SpendingController < ApplicationController
  before_action :check_content_type_json, :only => [:create]

  before_action :only => [:create] do
    check_params_exist :value, :spending_type_id, :spending_date
  end

  before_action :authenticate, :only => [:create]

  def create
    spendingDate = nil
    begin
      spendingDate = params[:spending_date].to_date
    rescue
      render :json => {:errors => ['incorrect date format']}, :status => :bad_request
      return
    end

    unless params[:value].to_d.to_s == params[:value].to_s
      render :json => {:errors => ['spending value should be a decimal number']}, :status => :bad_request
      return
    end

    spendingType = SpendingType.find_by_id(params[:spending_type_id])
    unless spendingType
      render :json => {:errors => ['spending type not found']}, :status => :bad_request
      return
    end

    spending = @user.spendings.build
    spending.date_of_spending = spendingDate
    spending.spending_type = spendingType
    spending.value = params[:value]

    if spending.save
      render :nothing => true, :status => :ok
    else
      render :json => {:errors => spending.errors.full_messages}, :status => :bad_request
    end

  end
end
