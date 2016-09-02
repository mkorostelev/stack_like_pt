class Admin::PostsController < Admin::BaseController
  def destroy
    resource.is_deleted = !resource.is_deleted
    resource.save!

    head :ok
  end

  private
  def resource
    @post ||= Post.find(params&.symbolize_keys[:id])
  end

  def collection
    @collection ||= Post.page(params[:page]).per(5)
  end

end
