# Post
class Post < ApplicationRecord
  alias_attribute :user, :author

  belongs_to :author, class_name: 'User'

  belongs_to :category

  has_many :likes, as: :likeable

  has_many :comments, dependent: :destroy

  validates :title, presence: true

  scope :visible, -> { where(is_deleted: false).joins(:author).where(users:
                                                        { is_banned: false }) }
end
