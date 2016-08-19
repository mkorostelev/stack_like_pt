require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { should route(:get, 'api/users').to(action: :index) }

  it { should route(:post, 'api/users').to(action: :create) }

  it { should route(:patch, 'api/users/1').to(action: :update, id: 1) }

  it { should route(:put, 'api/users/1').to(action: :update, id: 1) }

  it { should route(:delete, 'api/users/1').to(action: :destroy, id: 1) }

  # describe '#create.json' do
  #   before { expect(subject).to receive(:build_resource) }
  #
  #   # before do
  #   #   expect(subject).to receive(:resource) do
  #   #     double.tap { |a| expect(a).to receive(:save) }
  #   #   end
  #   # end
  #
  #   before do
  #     expect(subject).to receive(:resource) do
  #       double.tap do |a|
  #         expect(a).to receive(:save) do
  #           double.tap { |b| expect(b).to receive(:valid?).and_return true}
  #         end
  #       end
  #     end
  #   end
  #
  #   before { post :create, user: { email: 'one@digits.com', password: '12345678', first_name: 'Name', last_name: 'Surname' }, format: :json }
  #
  #   it { expect(response).to have_http_status(:created) }
  # end

  # describe '#destroy.json' do
  #   let(:user) { stub_model User }
  #
  #   before { sign_in user }
  #
  #   before do
  #     expect(subject).to receive(:resource) do
  #       double.tap { |a| expect(a).to receive(:destroy!) }
  #     end
  #   end
  #
  #   before { delete :destroy, format: :json }
  #
  #   it { expect(response.status).to eq(200) }
  # end

  describe '#build_resource' do
    # @user = User.new resource_params
    let(:params) { { foo: :bar } }

    before { expect(subject).to receive(:resource_params).and_return params }

    before { expect(User).to receive(:new).with(params) }

    it { expect { subject.send(:build_resource) }.to_not raise_error }
  end

  # describe '#collection' do
  #   before { expect(subject).to receive(:params).and_return(:params) }
  #
  #   before { expect(User).to receive(:page).with(:params) }
  #
  #   it { expect { subject.send :collection }.to_not raise_error }
  # end

end