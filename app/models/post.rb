class Post < ActiveRecord::Base
  # belongs_to :user, class_name: 'User',
  #            foreign_key: 'author_id',
  #            dependent: :destroy
belongs_to :author, class_name: 'User',
             # foreign_key: 'author_id',
             dependent: :destroy

  belongs_to :category, dependent: :destroy

  has_many :likes, as: :likeable

  validates :title, presence: true

  validates :rating, numericality: { greater_than_or_equal_to: 0 }

end
