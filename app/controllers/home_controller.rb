class HomeController < ApplicationController
  before_action :authenticate
  def index
    render :nothing => true
  end
  protected
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        true
      end
    end
end
