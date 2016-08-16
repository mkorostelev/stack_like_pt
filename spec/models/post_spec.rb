require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:author).dependent(:destroy) }

  it { should belong_to(:category).dependent(:destroy) }

  it { should validate_presence_of :title }

  it do
    should validate_numericality_of(:rating).
        is_greater_than_or_equal_to(0)
  end

  it { should have_many(:likes) }
end
