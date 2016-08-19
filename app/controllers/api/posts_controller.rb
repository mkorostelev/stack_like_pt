class Api::PostsController < ApplicationController

  private
  def build_resource
    @post = Post.new resource_params
  end

  def resource
    @post ||= Post.find(params&.symbolize_keys[:id])
  end

  def resource_params
    params.require(:post).permit(:title, :description).merge(author: current_user, category_id: params[:category_id])
  end

  def collection
    @collection ||= Post.page(params[:page]).per(5)
  end

end
