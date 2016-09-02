class Admin::CategoriesController < Admin::BaseController
  private

  def build_resource
    @category = Category.new resource_params
  end

  def resource
    @category ||= Category.find(params[:id])
  end

  def resource_params
    params.require(:category).permit(:title)
  end

  def collection
    @collection ||= Category.page(params[:page]).per(5)
  end
end
