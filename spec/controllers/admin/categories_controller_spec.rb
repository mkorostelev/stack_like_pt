require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!
    # end

    # def build_resource
    #   @category = Category.new resource_params
    # end

    # def resource
    #   @category ||= Category.find(params[:id])
    # end

    # def resource_params
    #   params.require(:category).permit(:title)
    # end

    let(:params) { { id: '1', category: { title: '1' } } }

    let(:resource) { stub_model Category }

    let(:user) { stub_model User, is_admin: true }

    before { sign_in user }

    before do
      expect(Category).to receive(:new).with(permit!(title: '1'))
                                                  .and_return(resource)
    end

    before { expect(resource).to receive(:save!) }

    before { post :create, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(Category).to receive(:page).with(5) do
        double.tap do |a|
          expect(a).to receive(:per).with(5) do
          end
        end
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end
end
