require 'rails_helper'
  describe '投稿管理機能', type: :system do
    describe '投稿一覧表示機能' do
        before do
          user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
          FactoryBot.create(:task, name: '最初のタスク', user: user_a)

          visit login_path
          fill_in 'メールアドレス', with: 'a@example.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
        end

        context 'ユーザーAがログインしている時' do
            it 'ユーザーAが作成した投稿が表示される' do
                expect(page).to have_content '最初のタスク'
            end
        end

        context 'ユーザーBがログインしてる時' do
          before do
              FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
          end

            it 'ユーザーAが作成した投稿が表示されない' do
                expect(page).to have_no_content '最初のタスク'
            end
        end
    end
end
