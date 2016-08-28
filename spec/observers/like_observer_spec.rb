require 'rails_helper'

RSpec.describe LikeObserver, type: :observer do
  let(:like) { stub_model Like }

  subject { described_class.send(:new) }

  describe '#after_create' do
    before { expect(subject).to receive(:change_rating) }

    it { expect { subject.after_save(like) }.to_not raise_error }
  end

  describe '#after_destroy' do
    before { expect(subject).to receive(:change_rating) }

    it { expect { subject.after_destroy(like) }.to_not raise_error }
  end

  describe '#change_rating' do
    # change_post_and_author_rating coef
    # change_comment_and_author_rating coef if like.likeable.is_a?(Comment)

    before { expect(subject).to receive(:change_post_and_author_rating) }

    context 'post' do
      before do
        expect(subject).to receive(:like) do
          double.tap do |a|
            expect(a).to receive(:likeable) do
              double.tap { |b| expect(b).to receive(:is_a?).
                                              with(Comment).and_return false }
            end
          end
        end
      end
      it { expect { subject.send(:change_rating) }.to_not raise_error }
    end

    context 'comment' do
      before do
        expect(subject).to receive(:like) do
          double.tap do |a|
            expect(a).to receive(:likeable) do
              double.tap { |b| expect(b).to receive(:is_a?).
                                              with(Comment).and_return true }
            end
          end
        end
      end

      before { expect(subject).to receive(:change_comment_and_author_rating) }

      it { expect { subject.send(:change_rating) }.to_not raise_error }
    end
  end

  describe '#rating_value' do
    # @rating_value ||= like.positive? ?
    #           LIKE::LIKE_POSITIVE_RATE : LIKE_NEGATIVE_RATE

    context 'positive?' do
      before { expect(subject).to receive(:coef).and_return(1) }

      before do
        expect(subject).to receive(:like) do
          double.tap{ |a| expect(a).to receive(:positive?).and_return true }
        end
      end

      it { (subject.send(:rating_value)).should eq Like::LIKE_POSITIVE_RATE }
    end

    context 'negative?' do
      before { expect(subject).to receive(:coef).and_return(1) }

      before do
        expect(subject).to receive(:like) do
          double.tap{ |a| expect(a).to receive(:positive?).and_return false }
        end
      end

      it { (subject.send(:rating_value)).should eq Like::LIKE_NEGATIVE_RATE }
    end
  end

  describe '#change_post_and_author_rating' do
    # post.increment!(:rating, rating_value)
    # post.user.increment!(:rating, rating_value)

    before { expect(subject).to receive(:rating_value).twice.and_return 1 }

    before do
      expect(subject).to receive(:post) do
        double.tap { |a| expect(a).to receive(:increment!).with(:rating, 1) }
      end
    end

    before do
      expect(subject).to receive(:post) do
        double.tap do |a|
          expect(a).to receive(:user) do
            double.tap { |b| expect(b).to receive(:increment!).with(:rating, 1) }
          end
        end
      end
    end

    it { expect { subject.send(:change_post_and_author_rating) }.to_not raise_error }
  end

  describe '#change_comment_and_author_rating' do
    # comment.increment!(:rating, rating_value)
    # comment.user.increment!(:rating, rating_value)

    before { expect(subject).to receive(:rating_value).twice.and_return 1 }

    before do
      expect(subject).to receive(:comment) do
        double.tap { |a| expect(a).to receive(:increment!).with(:rating, 1) }
      end
    end

    before do
      expect(subject).to receive(:comment) do
        double.tap do |a|
          expect(a).to receive(:user) do
            double.tap { |b| expect(b).to receive(:increment!).with(:rating, 1) }
          end
        end
      end
    end

    it { expect { subject.send(:change_comment_and_author_rating) }.to_not raise_error }
  end

  describe '#comment' do
    # @comment ||= like.likeable

    before do
      expect(subject).to receive(:like) do
        double.tap { |a| expect(a).to receive(:likeable) }
      end
    end

    it { expect { subject.send(:comment) }.to_not raise_error }
  end

  describe '#post' do
    # @post ||= like.likeable.is_a?(Post) ? like.likeable : like.likeable.post

    context 'post' do
      before do
        expect(subject).to receive(:like) do
          double.tap do |a|
            expect(a).to receive(:likeable) do
              double.tap { |b| expect(b).to receive(:is_a?).
                                              with(Post).and_return true }
            end
          end
        end
      end

      before do
        expect(subject).to receive(:like) do
          double.tap { |a| expect(a).to receive(:likeable) }
        end
      end

      it { expect { subject.send(:post) }.to_not raise_error }
    end

    context 'comment' do
      before do
        expect(subject).to receive(:like) do
          double.tap do |a|
            expect(a).to receive(:likeable) do
              double.tap { |b| expect(b).to receive(:is_a?).
                                              with(Post).and_return false }
            end
          end
        end
      end

      before do
        expect(subject).to receive(:like) do
          double.tap do |a|
            expect(a).to receive(:likeable) do
              double.tap { |b| expect(b).to receive(:post) }
            end
          end
        end
      end

      it { expect { subject.send(:post) }.to_not raise_error }
    end
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
