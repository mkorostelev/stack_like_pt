class CommentObserver < ActiveRecord::Observer
  def after_save(comment)
    comment.post.increment!(:rating, Comment::COMMENT_RATE)
  end

  def after_destroy(comment)
    comment.post.decrement!(:rating, Comment::COMMENT_RATE)
  end
end
