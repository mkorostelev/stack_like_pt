require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :controller do
  describe '#collection' do
    it { expect { subject.send :collection }.to_not raise_error }
  end
end