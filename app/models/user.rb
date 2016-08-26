class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  # validates :token, uniqueness: true

  validates_uniqueness_of :token, :allow_blank => true, :allow_nil => true

  has_many :likes

  has_many :comments

  has_many :posts, foreign_key: 'author_id'

  scope :admin, -> { where(is_admin: true)  }
end
