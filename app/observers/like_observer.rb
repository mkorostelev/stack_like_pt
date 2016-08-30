# change rating of User, Post and Comment by Like after_save and after_destroy
class LikeObserver < ActiveRecord::Observer
  attr_reader :like, :coef

  def after_save(record)
    @like = record

    @coef = 1

    change_rating
  end

  def after_destroy(record)
    @like = record

    @coef = -1

    change_rating
  end

  private

  def change_rating
    change_object_and_author_rating post

    change_object_and_author_rating comment if like.likeable.is_a?(Comment)
  end

  def change_object_and_author_rating(object)
    object.increment!(:rating, rating_value)
    object.user.increment!(:rating, rating_value)
  end

  def rating_value
    @rating_value = coef * (
      like.positive? ? Like::LIKE_POSITIVE_RATE : Like::LIKE_NEGATIVE_RATE) #!!!||
  end

  def comment
    @comment = like.likeable #!!!||
  end

  def post
    @post = like.likeable.is_a?(Post) ? like.likeable : like.likeable.post #!!!||
  end
end
