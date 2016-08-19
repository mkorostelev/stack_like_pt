class Api::CommentsController < ApplicationController

  def create
    super

    head :created
  end

  private
  def build_resource
    @comment = Comment.new resource_params
  end

  def resource
    @comment ||= Comment.find(params&.symbolize_keys[:id])
  end

  def resource_params
    params.require(:comment).permit(:text).merge(user: current_user, post_id: params[:post_id])
  end

  def collection
    @collection ||= Comment.page(params[:page]).per(5)
  end

end
