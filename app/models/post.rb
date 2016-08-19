class Post < ActiveRecord::Base
belongs_to :author, class_name: 'User'

  belongs_to :category

  has_many :likes, as: :likeable

  has_many :comments, dependent: :destroy

  validates :title, presence: true

  validates :rating, numericality: { greater_than_or_equal_to: 0 }

end
