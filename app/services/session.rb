class Session
  include ActiveModel::Validations

  attr_reader :email, :password, :user

  def initialize params
    params = params&.symbolize_keys || {}
    @user = params[:user]
    @email = params[:email]
    @password = params[:password]
  end

  validate do |model|
    if user
      model.errors.add :password, 'is invalid' unless user.authenticate password
    else
      model.errors.add :email, 'not found'
    end
  end

  def save!
    raise ActiveModel::StrictValidationFailed unless valid?

    user.token ||= SecureRandom.uuid

    user.save
  end

  def destroy!
    user.token = nil

    user.save
  end

  def token
    user.try(:token)
  end

  def as_json *args
    { token: token }
  end

  def decorate
    self
  end

  private
  def user
    @user ||= User.find_by email: email
  end
end
