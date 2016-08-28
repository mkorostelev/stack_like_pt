class Like < ApplicationRecord
  LIKE_POSITIVE_RATE = 1
  LIKE_NEGATIVE_RATE = -1

  enum kind: [:positive, :negative]

  belongs_to :user

  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
end
