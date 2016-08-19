class CommentDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
        id: id,
        user_id: user_id,
        post_id: post_id,
        text: text,
        rating: rating
    }
  end
end
