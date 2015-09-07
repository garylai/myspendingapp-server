require 'jwt'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from StandardError, with: :handle_exception

  def not_found
    render nothing: true, status: 404
  end

  protected
    def authenticate
      has_token = false
      authenticate_with_http_token do |token, options|
        begin
          payload, header = JWT.decode token, Rails.application.secrets.hmac_key, true, { :algorithm => Rails.application.secrets.token_algo }
          @user = User.find(payload['u_id'])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
          print_error e
          render_unauthorized 'invalid token'
        ensure
          has_token = true
        end
      end
      render_unauthorized 'HTTP Token: Access denied' unless has_token
    end

    def render_unauthorized(msg, realm = "Application")
        headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
        render :json => {:error => [msg]}, :status => :unauthorized
    end

    def check_content_type_json
      render :json => {:errors =>  ['accept only json']}, :status => :bad_request unless request.content_type == 'application/json'
    end

    def handle_exception(e)
      print_error e
      render :json => {:errors => ['server error']}, status: :internal_server_error
    end

    def check_params_exist(*param_names)
      errors = []
      param_names.each do |name|
        val = params[name]
        errors << "#{name} cannot be blank" if val.blank?
      end
      render :json => {:errors => errors}, :status => :bad_request if errors.count > 0
    end

    def print_error(e)
      Rails.logger.error e.inspect
      e.backtrace.take(10).each do |t|
        Rails.logger.error t
      end
    end
end
