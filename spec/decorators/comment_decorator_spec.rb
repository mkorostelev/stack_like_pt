require 'rails_helper'

RSpec.describe CommentDecorator do
  describe '#as_json' do
    let(:comment) { stub_model Comment, user_id: 1, id: 2, post_id: 3, text: 'text', rating: 0 }

    subject { comment.decorate.as_json }

    its([:rating]) {should eq 0}
  end
end
