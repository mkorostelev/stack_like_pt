class Api::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations

  def create
    build_resource

    resource.save

    if resource.valid? then
      head :created
    else
      head :unprocessable_entity
    end
  end

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user ||= User.find(params&.symbolize_keys[:id]) || current_user
  end

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def collection
    @collection ||= User.page(params[:page]).per(5)
  end

end
