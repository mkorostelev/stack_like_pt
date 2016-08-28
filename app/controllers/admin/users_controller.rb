class Admin::UsersController < Admin::BaseController
  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations

  private

  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                  :password_confirmation, :is_admin)
  end

  def collection
    @collection ||= User.page(params[:page]).per(5)
  end
end
