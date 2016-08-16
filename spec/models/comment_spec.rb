require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user).dependent(:destroy) }

  it { should belong_to(:post).dependent(:destroy) }

  it { should validate_presence_of :text }

  it do
    should validate_numericality_of(:rating).
        is_greater_than_or_equal_to(0)
  end

  it { should have_many(:likes) }
end
