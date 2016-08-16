class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
    #code
  end
  #code
end
