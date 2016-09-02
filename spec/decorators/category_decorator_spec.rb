require 'rails_helper'

RSpec.describe CategoryDecorator do
  describe '#as_json' do
    let(:category) { stub_model Category, title: 'title' }

    subject { category.decorate.as_json }

    its([:title]) {should eq 'title'}
  end
end
