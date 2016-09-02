require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  it { should route(:get, 'api/comments').to(action: :index) }

  it { expect(post: 'api/posts/1/comments').to be_routable }

  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!

    #   head :created
    # end

    # private
    # def parent
    #   @parent ||= Post.find(params[:post_id])
    # end

    # def build_resource
    #   @comment = parent.comments.new resource_params.merge(user: current_user)
    # end

    # def resource
    #   @comment ||= Comment.find(params&.symbolize_keys[:id])
    # end

    # def resource_params
    #   params.require(:comment).permit(:text)
    # end

    let(:params) { { post_id: '1', comment: { text: '1' } } }

    let(:post1) { stub_model Post }

    before { expect(Post).to receive(:find).with('1').and_return(post1) }

    let(:user) { stub_model User }

    let(:comment) { stub_model Comment }

    before { sign_in user }

    before do
      expect(post1).to receive(:comments) do
        double.tap { |a| expect(a).to receive(:new).with(permit!(text: '1', user: user))
                                                  .and_return(comment) }
      end
    end

    before { expect(comment).to receive(:save!) }

    # before { sign_in }

    # before { expect(subject).to receive(:build_resource) }

    # before do
    #   expect(subject).to receive(:resource) do
    #     double.tap { |a| expect(a).to receive(:save!) }
    #   end
    # end

    before { post :create, params: params, format: :json }

    it { expect(response).to have_http_status(:created) }
  end
end
