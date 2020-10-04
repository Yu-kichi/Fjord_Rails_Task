require "rails_helper"

describe "日報投稿機能", type: :system do
  describe "一覧表示機能" do
    before do 
      Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid: "bobtest")
      FactoryBot.create(:report, user: Bob)
    end
    it "日報一覧画面の表示(index)" do
      visit root_path
      click_on "日報"
      expect(page).to have_content "日報一覧"
    end
    
    context "ユーザーaがログインしている時" do 
      before do 
        visit new_user_session_path
        fill_in "Eメール", with: "bob@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end

      it "新規投稿する(create_report)" do 
        visit root_path
        click_on "日報"
        click_on "新規作成"
  
        fill_in "タイトル", with: "最初の日報"
        fill_in "内容", with: "今日からキャンプに入るよ！"
        expect{click_button "登録する"}.to change{Report.count }.by(1)
        assert_text "日報を作成しました！"
        assert_text "最初の日報"
        assert_text "今日からキャンプに入るよ！"
      end

      it "日報の編集をする(update_report)" do 
        visit root_path
        click_on "日報"
        click_on "編集"
        
        fill_in "タイトル", with: "３日目"
        fill_in "内容", with: "ちょっと慣れてきた"
        click_on "更新する"

        assert_text "日報を更新しました！"
        assert_text "３日目"
        assert_text "ちょっと慣れてきた"
      end

      it "日報を削除する(destroy_report)" do 
        visit root_path
        click_on "日報"
        click_on "削除"
        expect{
          page.accept_confirm "本当に削除しますか？"
          expect(page).to have_content "日報を削除しました！"
        }.to change { Report.count }.by(-1)
      end
    end
  end
end
