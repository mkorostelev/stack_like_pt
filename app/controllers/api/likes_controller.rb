class Api::LikesController < ApplicationController

  def create
    super

    head :created
  end

  private
  def build_resource
    @like = Like.new resource_params
  end

  def resource
    @like ||= current_user.likes.find_by(likeable_id: resource_params[:likeable_id], likeable_type: resource_params[:likeable_type])
  end

  def resource_params

    #!!!
    # permitted_params = params.require(:like).permit(:kind).merge(user: current_user)
    # if params[:post_id]
    #   permitted_params.merge(likeable_type: 'Post', likeable_id: params[:post_id])
    # else
    #   permitted_params.merge(likeable_type: 'Comment', likeable_id: params[:comment_id])
    # end
    # permitted_params
    if params[:post_id]
      params.require(:like).permit(:kind).merge(user: current_user,likeable_type: 'Post', likeable_id: params[:post_id])
    else
      params.require(:like).permit(:kind).merge(user: current_user, likeable_type: 'Comment', likeable_id: params[:comment_id])
    end


  end
end
