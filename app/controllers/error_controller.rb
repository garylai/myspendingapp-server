class ErrorController < ApplicationController
  def not_found
    render nothing: true, status: :not_found
  end
  def bad_request
    render nothing: true, status: :bad_request
  end
  def internal_server_error
    render nothing: true, status: :internal_server_error
  end
end
