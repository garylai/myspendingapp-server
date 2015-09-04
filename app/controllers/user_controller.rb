class UserController < ApplicationController
  before_action :check_content_type_json, :only => [:create]
  def create
    puts 'create'
    puts @params
    render :nothing => true, :status => :ok
  end
end
