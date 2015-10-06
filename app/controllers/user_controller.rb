require 'password_helper'
require 'jwt'

class UserController < ApplicationController
  before_action :check_content_type_json, :only => [:create, :login]
  before_action :only => [:create] do
    check_params_exist :name, :email, :password
  end
  before_action :only => [:login] do
    check_params_exist :email, :password
  end

  def create
    user = User.new(params.permit(:name, :email, :password))

    if user.save
      dict = user.as_json
      dict["token"] = createToken(user)
      render :json => dict, :only => ["name", "email", "id", "token"], :status => :ok
    else
      render :json => {:errors => user.errors_without_readonly_fields.full_messages}, :status => :bad_request
    end
  end

  def login
    email = params[:email]
    password = params[:password]
    user = User.where(email: params[:email]).first

    if !user
      render :json => {:errors => ['user not found']}, :status => :forbidden
      return
    end

    if !user.is_password_correct? password
      render :json => {:errors => ['pssword not valid']}, :status => :forbidden
      return
    end

    render :json => {:id => user.id, :token => createToken(user)}, :status => :ok
  end

  private
  def createToken(user)
      payload = {:u_id => user.id, :iat => Time.now.to_i}
      return JWT.encode payload, Rails.application.secrets.hmac_key, Rails.application.secrets.token_algo
  end
end
