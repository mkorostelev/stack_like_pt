class NotificationsObserver < ActiveRecord::Observer
  observe :like

  def after_create(record)
    byebug
    # notifiy users of new comment or like
  end

end