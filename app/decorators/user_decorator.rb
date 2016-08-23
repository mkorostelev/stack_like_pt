class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      full_name: full_name,
      email: email
    }
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
