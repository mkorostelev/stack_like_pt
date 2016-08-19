class PostDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    if context[:show_comments]
      {
          id: id,
          title: title,
          description: description,
          rating: rating,
          author: author.decorate,
          comments: comments.decorate
      }
    else
      {
          id: id,
          title: title,
          description: description,
          rating: rating,
          author: author.decorate
      }
    end

  end
end
