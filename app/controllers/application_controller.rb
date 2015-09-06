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
      authenticate_or_request_with_http_token do |token, options|
        true
      end
    end

    def check_content_type_json
      render :json => {'error': 'accept only json'}, :status => :bad_request unless request.content_type == 'application/json'
    end

    def handle_exception(e)
      render :json => {'errors': ['server error']}, status: :internal_server_error
      Rails.logger.error e.inspect
      Rails.logger.error e.backtrace.take(10).join("\n")
    end

    def check_params_exist(*param_names)
      errors = []
      param_names.each do |name|
        val = params[name]
        errors << "#{name} cannot be blank" if val.blank?
      end
      render :json => {:errors => errors}, :status => :bad_request if errors.count > 0
    end
end
