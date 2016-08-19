class Api::CategoriesController < ApplicationController

  private

  def collection
    @collection ||= Category.page(params[:page]).per(5)
  end

end
