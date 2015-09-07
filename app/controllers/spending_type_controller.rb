class SpendingTypeController < ApplicationController
  def index
    # TODO: cache it
    render :json => {:spending_type => SpendingType.all}, :status => :ok
  end
end
