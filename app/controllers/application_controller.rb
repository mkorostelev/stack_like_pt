class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :resource, :collection

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :authenticate

  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @exception = exception

    render :exception
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  def new
    initialize_resource
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update! resource_params
  end

  def destroy
    resource.destroy!

    head :ok
  end

  private
  def json_request?
    request.format.json?
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end
end
