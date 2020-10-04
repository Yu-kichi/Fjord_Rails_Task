require "rails_helper"

describe "book投稿機能", type: :system do
  describe "一覧表示機能" do
    before do 
      Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid: "bobtest")
      FactoryBot.create(:book, title: "よくわかるテスト", user: Bob)
    end

    context "ユーザーaがログインしている時" do 
      before do 
        visit new_user_session_path
        fill_in "Eメール", with: "bob@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "ログインしたら本の一覧画面になる(index)" do 
        expect(page).to have_content "書籍一覧"
      end

      it "新規投稿する(create_book)" do 
        visit root_path
        click_on "新規作成"

        fill_in "作品名", with: "Ruby超入門"
        fill_in "著者名", with: "igaiga"
        fill_in "メモ", with: "rubyのことがよくわかる！"
        expect{click_button "登録する"}.to change{ Book.count }.by(1)
        assert_text "本を作成しました！"
        assert_text "Ruby超入門"
        assert_text "igaiga"
        assert_text "rubyのことがよくわかる！"
      end

      it "本の編集をする(update_book)" do 
        visit root_path
        click_on "編集"
        
        fill_in "作品名", with: "Ruby超入門ですよ"
        fill_in "著者名", with: "igaigaですよ"
        fill_in "メモ", with: "rubyのことがよくわかりますよ！"
        click_button "更新する"

        assert_text "本を更新しました！"
        assert_text "Ruby超入門ですよ"
        assert_text "igaigaですよ"
        assert_text "rubyのことがよくわかりますよ！"
      end
      
      it "本を削除する(destroy_book)" do 
        visit root_path
        click_on "削除"
        expect{
          page.accept_confirm "本当に削除しますか？"
          expect(page).to have_content "本を削除しました！"
        }.to change { Book.count }.by(-1)
      end
    end    
  end
end