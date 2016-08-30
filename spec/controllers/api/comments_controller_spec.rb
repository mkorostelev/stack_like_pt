require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  it { should route(:get, 'api/comments').to(action: :index) }

  it { expect(post: 'api/comments/1/likes').to be_routable }

  it { expect(delete: 'api/comments/1/likes').to be_routable }

  # describe '#create.json' do
  #   let(:comment) { stub_model Comment }

  #   before { expect(subject).to receive(:build_resource) }

  #   before do
  #     expect(subject).to receive(:resource) do
  #       double.tap { |a| expect(a).to receive(:save!) }
  #     end
  #   end

  #   before { post :create, comment: comment, format: :json }

  #   it { expect(response).to have_http_status(:created) }
  # end
end
