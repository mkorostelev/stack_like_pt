require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  it { should route(:get, 'admin/posts').to(action: :index) }

  it { should route(:get, 'admin/posts/1').to(action: :show, id: 1) }

  it { should route(:delete, 'admin/posts/1').to(action: :destroy, id: 1) }

  it { expect(get: 'admin/posts/1').to be_routable }

  describe '#destroy' do
    #  def destroy
    #   resource.is_deleted = !resource.is_deleted
    #   resource.save!

    #   head :ok
    # end

    # private
    # def resource
    #   @post ||= Post.find(params&.symbolize_keys[:id])
    # end

    # def collection
    #   @collection ||= Post.page(params[:page]).per(5)
    # end

    let(:user) { stub_model User, is_admin: true }

    before { sign_in user }

    let(:object) { stub_model Post }

    let(:params) { { id: '1' } }

    before { expect(Post).to receive(:find).with('1').and_return(object) }

    before { expect(object).to receive(:is_deleted) }

    before { expect(object).to receive(:save!) }

    before { delete :destroy, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(Post).to receive(:page).with(5) do
        double.tap do |a|
          expect(a).to receive(:per).with(5) do

          end
        end
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end
end
