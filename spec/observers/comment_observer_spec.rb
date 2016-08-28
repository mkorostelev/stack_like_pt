require 'rails_helper'

RSpec.describe CommentObserver, type: :observer do
  let(:record) { stub_model Comment }

  subject { described_class.send(:new) }

  describe '#after_create' do
    # comment.post.increment!(:rating, Comment::COMMENT_RATE)

    before do
      expect(subject).to receive(:comment) do
        double.tap do |a|
          expect(a).to receive(:post) do
            double.tap { |b| expect(b).to receive(:increment!).with(:rating, 1) }
          end
        end
      end
    end

    it { expect { subject.after_save(record) }.to_not raise_error }
  end
end
