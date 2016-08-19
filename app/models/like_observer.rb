class LikeObserver < ActiveRecord::Observer
  def after_save(like)
    byebug
    Notifications.like(like).deliver
  end

  def after_destroy(like)
    byebug
    Notifications.like(like).deliver
  end
end
