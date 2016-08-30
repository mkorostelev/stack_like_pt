class Api::CommentsController < ApplicationController

  def create
    super

    head :created
  end

  private
  def parent
    @parent ||= Post.find(params[:post_id])
  end

  def build_resource
    @comment = parent.comments.new resource_params.merge(user: current_user)
  end

  def resource
    @comment ||= Comment.find(params&.symbolize_keys[:id])
  end

  def resource_params
    params.require(:comment).permit(:text)
  end

  def collection
    @collection ||= Comment.visible.page(params[:page]).per(5)
  end

end
