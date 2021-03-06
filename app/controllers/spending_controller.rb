class SpendingController < ApplicationController
  before_action :check_content_type_json, :only => [:create]

  before_action :only => [:create] do
    check_params_exist :value, :spending_type_id, :date_of_spending
  end

  before_action :authenticate, :only => [:create, :index]

  def index
    if params.has_key? :day
      begin
        targetDate = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      rescue
        render :errors => ['incorrect date format'], :status => :bad_request
        return
      end
      render :json => @user.spendings.in_day(targetDate), :status => :ok
    elsif params.has_key? :month
      render :json => @user.spendings.sum_over_days(params[:year], params[:month]).group_by{|s| s.day_of_spending},
            :except => [:id, :day_of_spending],
            :status => :ok
    elsif params.has_key? :year
      render :json => @user.spendings.sum_over_months(params[:year]).group_by{|s| s.month_of_spending},
            :except => [:id, :month_of_spending],
            :status => :ok
    else
      render :json => @user.spendings.sum_over_years.group_by{|s| s.year_of_spending},
            :except => [:id, :year_of_spending],
            :status => :ok
    end
  end

  def create
    spendingDate = nil
    begin
      spendingDate = params[:date_of_spending].to_date
    rescue
      render :json => {:errors => ['incorrect date format']}, :status => :bad_request
      return
    end
    p 'value'
    p params[:value]
    unless params[:value].to_d.to_s == params[:value].to_s ||
            params[:value].to_i.to_s == params[:value].to_s
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
    spending.note = params[:note]

    if spending.save
      render :json => spending, :status => :ok
    else
      render :json => {:errors => spending.errors.full_messages}, :status => :bad_request
    end

  end
end
