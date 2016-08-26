class Post < ApplicationRecord
belongs_to :author, class_name: 'User'

  belongs_to :category

  has_many :likes, as: :likeable

  has_many :comments, dependent: :destroy

  validates :title, presence: true

  scope :visible, -> { where(is_deleted: false)  }

end
