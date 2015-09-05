class ErrorController < ApplicationController
  def not_found
    render nothing: true, status: :not_found
  end
  def bad_request
    render nothing: true, status: :bad_request
  end
end
