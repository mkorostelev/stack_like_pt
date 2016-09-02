require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(User).to receive(:page).with(5) do
        double.tap { |a| expect(a).to receive(:per).with(5) }
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end

  describe '#update.json' do
    # resource.update! resource_params

    # def resource
    #   @user ||= params[:id] ? User.non_admin.find(params[:id]) : current_user
    # end

    # def resource_params
    #   params.require(:user).permit(:first_name, :last_name, :email, :password,
    #                         :password_confirmation, :is_admin, :is_banned)
    # end

    let(:user) { stub_model User }

    before { sign_in user }

    context 'current_user' do
      let(:params) {
                    { user:
                        { first_name: 'Name',
                          last_name: 'Surname',
                          email: 'mail@mail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          is_admin: 'false', is_banned: 'false'
                        }
                    }
                  }

      before { expect(user).to receive(:update!)
        .with(permit!({first_name: 'Name',
                      last_name: 'Surname',
                      email: 'mail@mail.com',
                      password: 'password',
                      password_confirmation: 'password',
                      is_admin: 'false', is_banned: 'false' })) }

      before { patch :update, params: params, format: :json }

      it { expect(response).to have_http_status(:ok) }
    end
  end
end
