class SpendingTypeController < ApplicationController
  def index
    expires_in 30.minutes, :public => true
    render :json => {:spending_type => SpendingType.all}, :status => :ok
  end
end
