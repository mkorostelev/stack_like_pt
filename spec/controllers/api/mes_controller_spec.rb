require 'rails_helper'

RSpec.describe Api::MesController, type: :controller do
  it { should route(:get, 'api/me').to(action: :show)  }

  describe '#resource' do
    # @user ||= current_user
    let(:user) { stub_model User }

    before { expect(subject).to receive(:current_user) }

    it { expect { subject.send(:resource) }.to_not raise_error }
  end
end