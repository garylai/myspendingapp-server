class SpendingController < ApplicationController
  before_action :check_content_type_json, :only => [:create]

  before_action :only => [:create] do
    check_params_exist :name, :email, :password
  end

  before_action :authenticate, :only => [:create]

  def create
    
    render :nothing => true, :status => :ok
  end
end
