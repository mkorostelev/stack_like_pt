class Api::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations

  def update
    authorize resource

    super
  end

  def save!
    byebug
    @user.save

    head :unprocessable_entity unless @user.valid?

    head :created
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

end
