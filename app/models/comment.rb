class Comment < ApplicationRecord
  COMMENT_RATE = 3

  belongs_to :user

  belongs_to :post

  has_many :likes, as: :likeable

  validates :text, presence: true

  scope :visible, -> { where(is_deleted: false).joins(:user).where(users:
                                                        { is_banned: false }) }
end
