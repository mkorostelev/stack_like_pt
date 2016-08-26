class LikeObserver < ActiveRecord::Observer
  COMMENT_WEIGHT = 3
  LIKE_WEIGHT = 1

  observe :comment, :like

  def after_save(record)
    @record = record

    change_rating
  end

  def after_destroy(record)
    @record = record

    change_rating -1
  end

  def change_rating(coef = 1)
    object.increment!(:rating, coef * rating_change_value)

    if is_a_comment object
      user = object.user
    elsif object.is_a?(Post)
      user = object.author
    end

    user.increment!(:rating, coef * rating_change_value)

    if need_to_rating_parent_post
      object.post.increment!(:rating, coef * LIKE_WEIGHT)
    end
  end

  def rating_change_value
    return @rating_change_value if @rating_change_value
    if @record.is_a?(Like)
      @rating_change_value = LIKE_WEIGHT * (@record.positive? ? 1 : -1)
    elsif @record.is_a?(Comment)
      @rating_change_value = COMMENT_WEIGHT
    end
    @rating_change_value
  end

  def object
    return @object if @object
    if is_a_like
      @object = @record.likeable
    elsif is_a_comment
      @object = @record.post
    end
    @object
  end

  def is_a_comment(record = @record)
    record.is_a?(Comment)
  end

  def is_a_like(record = @record)
    record.is_a?(Like)
  end

  def need_to_rating_parent_post
    @need_to_rating_parent_post ||= is_a_like && @record.positive? && is_a_comment(object)
  end
end

