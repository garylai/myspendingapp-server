class UserController < ApplicationController
  before_action :check_content_type_json, :only => [:create]

  def create
    user = User.new(params.permit(:name, :email, :password))

    if user.save
        render :json => user, :only => [:name, :email, :id], :status => :ok
    else
      render :json => {:errors => user.errors_without_readonly_fields.full_messages}, :status => :bad_request
    end
  end

  def
end
