require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#as_json' do
    let(:user) { stub_model User, first_name: 'Name', last_name: 'Surname', email: 'test@test.com' }

    subject { user.decorate.as_json }

    its([:full_name]) {should eq 'Name Surname'}
  end
end