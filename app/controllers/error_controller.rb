class ErrorController < ApplicationController
  def not_found
    render nothing: true, status: :not_found
  end
end
