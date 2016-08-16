class Comment < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  belongs_to :post, dependent: :destroy

  has_many :likes, as: :likeable

  validates :text, presence: true

  validates :rating, numericality: { greater_than_or_equal_to: 0 }
end
