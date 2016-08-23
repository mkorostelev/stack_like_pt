class LikeObserver < ActiveRecord::Observer
  observe :like

  def after_save(like)
    #!!!
    unless like.is_a?(Like)
      return
    end
    @like = like
    likeable_object.increment(:rating, rating_change_value)
    likeable_object.save
  end

  def after_destroy(like)
    #!!!
    unless like.is_a?(Like)
      return
    end
    @like = like
    likeable_object.decrement(:rating, rating_change_value)
    likeable_object.save
  end

  def rating_change_value
    @like.positive? ? 1 : -1
  end

  def likeable_object
    @likeable_object ||= @like.likeable_type.constantize.find(@like.likeable_id)
  end
end
