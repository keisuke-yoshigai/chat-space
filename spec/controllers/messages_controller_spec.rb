require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'ログインしている場合' do
      login_user
      it '該当するビューが描画されている' do
        get :index
        expect(response).to render_template :index
      end
      it '@messageがある' do
        get :index
        expect(assigns(:message)).to be_a_new(Message)
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされる' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしているかつ、保存に成功した場合' do
      login_user
      it 'メッセージを保存できている' do
        expect{
          post :create, message: attributes_for(:message), group_id: group.id, user_id: user.id }.to change(Message, :count).by(1)
      end
      it '該当するビューが描画されている' do
        post :create, message: attributes_for(:message), group_id: group.id, user_id: user.id
        expect(response).to redirect_to group_messages_path(group.id)
      end
    end

    context 'ログインしているが、保存に失敗した場合' do
      login_user
       it 'メッセージの保存は行われない' do
        expect{
          post :create,
          { message: attributes_for(:invalid_message), group_id: group.id, user_id: user.id }
        }.not_to change(Message, :count)
      end
      it '意図したビューが描画されている' do
        post :create,
        { message: attributes_for(:invalid_message), group_id: group.id, user_id: user.id
          }
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされている' do
        post :create,
        { message: attributes_for(:invalid_message), group_id: group.id, user_id: user.id
          }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
