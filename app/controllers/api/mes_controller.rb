class Api::MesController < ApplicationController

  include ActiveModel::Validations

  private

  def resource
    @user ||= current_user
  end

end
