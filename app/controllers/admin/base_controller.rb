class Admin::BaseController < ApplicationController
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.admin.find_by(token: token)
    end
  end
end