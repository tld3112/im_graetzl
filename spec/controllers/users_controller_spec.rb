require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET show' do
    context 'when logged out' do
      before { get :show, id: create(:user) }

      it 'redirects to login with flash' do
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      let(:graetzl) { create(:graetzl) }
      let(:user) { create(:user, graetzl: graetzl) }
      before { sign_in create(:user) }

      context 'with right graetzl' do
        before { get :show, graetzl_id: graetzl, id: user }
        
        it 'assigns @graetzl' do
          expect(assigns(:graetzl)).to eq graetzl
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it 'renders :show' do
          expect(response).to render_template(:show)
        end
      end
      context 'with wrong graetzl' do
        let(:wrong_graetzl) { create(:graetzl) }
        before { get :show, graetzl_id: wrong_graetzl, id: user }
        
        it 'assigns @graetzl' do
          expect(assigns(:graetzl)).to eq wrong_graetzl
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it '301 redirects to user in right graetzl' do
          expect(response).to have_http_status(301)
          expect(response).to redirect_to [graetzl, user]
        end
      end
      context 'without graetzl' do
        before { get :show, id: user }

        it 'assigns @graetzl with nil' do
          expect(assigns(:graetzl)).to eq nil
        end

        it 'assigns @user' do
          expect(assigns(:user)).to eq user
        end

        it '301 redirects to user in right graetzl' do
          expect(response).to have_http_status(301)
          expect(response).to redirect_to [graetzl, user]
        end
      end
    end
  end

  describe 'GET edit' do
    context 'when logged out' do
      it 'redirects to login with flash' do
        get :edit
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      let(:user) { create(:user) }
      before do
        sign_in user
        get :edit
      end

      it 'assigns @user with current_user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders :edit' do
        expect(response).to render_template(:edit)
      end
    end
  end
  describe 'PUT update' do
    context 'when logged out' do
      it 'redirects to login with flash' do
        put :update, id: create(:user)
        expect(response).to render_template(session[:new])
        expect(flash[:alert]).to be_present
      end
    end
    context 'when logged in' do
      let!(:user) { create(:user) }
      let(:params) {
        {
          id: user,
          user: { email: 'new@newer.com' }
        }
      }
      before { sign_in user }
      
      describe 'change attributes' do

        it 'updates user record' do
          expect{
            put :update, params
            user.reload
          }.to change(user, :email)
        end

        it 'does not change password' do
          expect{
            put :update, params
            user.reload
          }.not_to change(user, :password)
        end

        describe 'request' do
          before { put :update, params }

          it 'assigns @user' do
            expect(assigns(:user)).to eq user
          end

          it 'redirect_to to current_user with notice' do
            expect(response).to redirect_to([user.graetzl, user])
            expect(flash[:notice]).to be_present
          end
        end
      end
      describe 'change password' do
        it "is a pending example"
      end
    end
  end
end