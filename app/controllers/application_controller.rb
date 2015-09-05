class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include ActionController::HttpAuthentication::Token::ControllerMethods
  def not_found
    render nothing: true, status: 404
  end
  protected
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        true
      end
    end

    def check_content_type_json
      render :json => {'error': 'accept only json'}, :status => :bad_request unless request.content_type == 'application/json'
    end
end
