class SpendingTypeController < ApplicationController
  def index
    expires_in 30.minutes, :public => true
    render :json => SpendingType.all.select(:id, :name), :status => :ok
  end
end
