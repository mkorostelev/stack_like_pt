require 'rails_helper'

RSpec.describe PostDecorator do
  describe '#as_json' do
    let(:user) { stub_model User }

    let(:post) { stub_model Post, id: 1, title: 'title',
        description: 'description', rating: 0, author: user,
        comments: [] }

    context '(context: {show_comments: true})' do
      subject { post.decorate(context: {show_comments: true}).as_json }

      its([:title]) {should eq 'title'}
    end

    context '(context: {show_comments: false})' do
      subject { post.decorate.as_json }

      its([:title]) {should eq 'title'}
    end
  end
end
