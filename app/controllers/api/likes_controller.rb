class Api::LikesController < ApplicationController
  def create
    super

    head :created
  end

  private

  def parent
    return @parent if @parent
    @parent = Post.find(params[:post_id]) if params[:post_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]
    @parent
  end

  def build_resource
    @like = parent.likes.new resource_params.merge(user: current_user)
  end

  def resource
    @like ||= parent.likes.find_by!(user: current_user)
  end

  def resource_params
    params.require(:like).permit(:kind)
  end
end
