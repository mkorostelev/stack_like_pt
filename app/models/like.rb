class Like < ActiveRecord::Base
  enum kind: [:positive, :negative]

  belongs_to :user, dependent: :destroy

  belongs_to :likeable, polymorphic: true
end
