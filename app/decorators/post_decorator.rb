class PostDecorator < Draper::Decorator
  delegate_all
  decorates_association :author
  decorates_association :comments

  def as_json *args
    if context[:show_comments]
      {
          id: id,
          title: title,
          description: description,
          rating: rating,
          author: author,
          comments: comments
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
