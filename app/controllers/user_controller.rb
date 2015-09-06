require 'PasswordHelper'
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
        render :json => user, :only => [:name, :email, :id], :status => :ok
    else
      render :json => {:errors => user.errors_without_readonly_fields.full_messages}, :status => :bad_request
    end
  end

  def login
    1/0
    email = params[:email]
    password = params[:password]
    user = User.where(email: params[:email]).first

    if !user
      render :json => {:error => ['user not found']}, :status => :forbidden
      return
    end

    if !user.is_password_correct? password
      render :json => {:error => ['pssword not valid']}, :status => :forbidden
      return
    end

    payload = {:u_id => user.id, :iat => Time.now.to_i}
    token = JWT.encode payload, Rails.application.secrets.hmac_key, Rails.application.secrets.token_algo

    render :json => {:id => user.id, :token => token}, :status => :ok
  end
end
