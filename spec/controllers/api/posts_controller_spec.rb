require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  it { should route(:get, 'api/posts').to(action: :index) }

  it { should route(:get, 'api/posts/1').to(action: :show, id: 1) }

  it { expect(get: 'api/posts/1').to be_routable }

  it { expect(post: 'api/posts/1/likes').to be_routable }

  it { expect(delete: 'api/posts/1/likes').to be_routable }

  it { expect(post: 'api/posts/1/comments').to be_routable }

  describe '#build_resource' do
    # @post = Post.new resource_params
    let(:params) { { foo: :bar } }

    before { expect(subject).to receive(:resource_params).and_return params }

    before { expect(Post).to receive(:new).with(params) }

    it { expect { subject.send(:build_resource) }.to_not raise_error }
  end

  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(Post).to receive(:visible) do
        double.tap do |a|
          expect(a).to receive(:page).with(5) do
            double.tap do |b|
              expect(b).to receive(:per).with(5)
            end
          end
        end
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end

  describe '#resource' do
    # @post ||= Post.find(params&.symbolize_keys[:id])

    before { expect(subject).to receive(:params).and_return({ id: 1 }) }

    before { expect(Post).to receive(:find).with(1) }

    it { expect { subject.send :resource }.to_not raise_error }
  end
end