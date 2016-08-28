ActiveRecord::Base.add_observer LikeObserver.instance
ActiveRecord::Base.add_observer CommentObserver.instance
