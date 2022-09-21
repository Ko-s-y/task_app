require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@sample.com', password: '1111') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@sample.com', password: '2222') }
    let!(:task_a) { FactoryBot.create(:task ,name: '最初のタスク', user: user_a) }

    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end

    describe '一覧表示機能' do
      context 'ユーザーAがログインしているとき' do
        let(:login_user) { user_a }


        it 'ユーザーAが作成したタスクが表示される' do
          expect(current_path).to eq(root_path)
          expect(page).to have_content '最初のタスク'
        end
      end

      context 'ユーザーBがログインしているとき' do
        let(:login_user) { user_b }

        it 'ユーザーAが作成したタスクが表示されない' do
          expect(page).to have_no_content '最初のタスク'
        end
      end
    end

    describe '詳細表示機能' do
      context 'ユーザーAがログインしているとき' do
        let(:login_user) { user_a }

        before do
          visit task_path(task_a)
        end

        it 'ユーザーAが作成したタスクが表示される' do
          expect(page).to have_content '最初のタスク'
        end
      end
    end
  end
end