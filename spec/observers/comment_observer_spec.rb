require 'rails_helper'

RSpec.describe CommentObserver, type: :observer do
  let(:comment) { stub_model Comment }

  subject { described_class.send(:new) }

  describe '#after_create' do
    # comment.post.increment!(:rating, Comment::COMMENT_RATE)

    before do
      expect(comment).to receive(:post) do
        double.tap { |a| expect(a).to receive(:increment!).with(:rating, Comment::COMMENT_RATE) }
      end
    end

    it { expect { subject.after_save(comment) }.to_not raise_error }
  end

  describe '#after_destroy' do
    # comment.post.decrement!(:rating, Comment::COMMENT_RATE)

    before do
      expect(comment).to receive(:post) do
        double.tap { |a| expect(a).to receive(:decrement!).with(:rating, Comment::COMMENT_RATE) }
      end
    end

    it { expect { subject.after_destroy(comment) }.to_not raise_error }
  end

  #
  # subject { described_class.send(:new) }
  #
  # describe '#before_create' do
  #   let(:user) { double }
  #
  #   let(:relation) { double }
  #
  #   before { expect(recovery).to receive(:recoverable).and_return(user) }
  #
  #   before { expect(Recovery).to receive(:where).with(recoverable: user).and_return(relation) }
  #
  #   before { expect(relation).to receive(:destroy_all) }
  #
  #   it { expect{ subject.before_create(recovery) }.to_not raise_error }
  # end
end
