require 'rails_helper'

RSpec.describe LikeObserver, type: :observer do

  describe '#after_save' do
    # @record = record
    # object.increment!(:rating, rating_change_value)

    let(:object) { stub_model Post }

    let(:rating_change_value) { 5 }

    let(:record) { double }

    before { expect { object.increment!(:rating, rating_change_value) }.to change{object.rating}.from(0).to(5)}

    # it { expect{ subject.after_save(record) }.to_not raise_error }

    # let(:object) { stub_model Post }
    #
    # let(:record) { double }
    #
    #!!! before { expect(object).to receive(:increment!) }
    #
    # it { expect{ subject.after_save(record) }.to_not raise_error }
  end

  describe '#after_destroy' do
    # @record = record
    # object.decrement!(:rating, rating_change_value)

    let(:object) { stub_model Post }

    let(:rating_change_value) { 5 }

    # it { expect { object.decrement!(:rating, rating_change_value) }.to change{object.rating}.from(0).to(-5)}

  end

  describe '#object' do
    # if @record.is_a?(Like)
    #   @record.likeable
    # elsif @record.is_a?(Comment)
    #   @record.post
    # end

    context 'Like' do
      let(:record) { stub_model Like }
      before { expect(record).to receive(:likeable).and_return(record.likeable) }
      # it { expect (subject.send :object).to eq(record.likeable) }
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
