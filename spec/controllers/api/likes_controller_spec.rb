require 'rails_helper'

RSpec.describe Api::LikesController, type: :controller do
  it { expect(post: 'api/comments/1/likes').to be_routable }

  it { expect(delete: 'api/comments/1/likes').to be_routable }

  it { expect(post: 'api/posts/1/likes').to be_routable }

  it { expect(delete: 'api/posts/1/likes').to be_routable }

  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!

    #   head :created
    # end

    # private

    # def parent
    #   return @parent if @parent
    #   @parent = Post.find(params[:post_id]) if params[:post_id]
    #   @parent = Comment.find(params[:comment_id]) if params[:comment_id]
    #   @parent
    # end

    # def build_resource
    #   @like = parent.likes.new resource_params.merge(user: current_user)
    # end

    # def resource
    #   @like ||= parent.likes.find_by!(user: current_user)
    # end

    # def resource_params
    #   params.require(:like).permit(:kind)
    # end

    let(:user) { stub_model User }

    let(:like) { stub_model Like }

    before { sign_in user }

    context 'post' do
      let(:params) { { post_id: '1', like: { kind: 'positive' } } }

      let(:parent) { stub_model Post }

      before { expect(Post).to receive(:find).with('1').and_return(parent) }

      before do
        expect(parent).to receive(:likes) do
          double.tap { |a| expect(a).to receive(:new).with(
                      permit!(kind: 'positive', user: user)).and_return(like) }
        end
      end

      before { expect(like).to receive(:save!) }

      before { post :create, params: params, format: :json }

      it { expect(response).to have_http_status(:created) }
    end

    context 'comment' do
      let(:params) { { comment_id: '1', like: { kind: 'positive' } } }

      let(:parent) { stub_model Comment }

      before { expect(Comment).to receive(:find).with('1').and_return(parent) }

      before do
        expect(parent).to receive(:likes) do
          double.tap { |a| expect(a).to receive(:new).with(
                      permit!(kind: 'positive', user: user)).and_return(like) }
        end
      end

      before { expect(like).to receive(:save!) }

      before { post :create, params: params, format: :json }

      it { expect(response).to have_http_status(:created) }
    end
  end
end
