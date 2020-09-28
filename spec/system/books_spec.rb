require "rails_helper"

describe "book投稿機能", type: :system do
  describe "一覧表示機能" do
    before do 
      Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid: "bobtest")
      FactoryBot.create(:book, title: "よくわかるテスト", user: Bob)
    end

    context "ユーザーaがログインしている時" do 
      before do 
        visit "ja/users/sign_in"
        fill_in "Eメール", with: "bob@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログイン"
      end
      it "ログインしたら本の一覧画面になる(index)" do 
        expect(page).to have_content "書籍一覧"
      end

      it "新規投稿する(create_book)" do 
        #visit "ja/books/new"
        visit "ja"
        click_button "新規作成"

        fill_in "作品名", with: "Ruby超入門"
        fill_in "著者名", with: "igaiga"
        fill_in "メモ", with: "rubyのことがよくわかる！"
        click_button "登録する"

        assert_text "Bookを作成しました！"
        assert_text "Ruby超入門"
        assert_text "igaiga"
        assert_text "rubyのことがよくわかる！"
      end

      it "本の編集をする(update_book)" do 
        visit "ja"
        click_on "編集"
        
        fill_in "作品名", with: "Ruby超入門ですよ"
        fill_in "著者名", with: "igaigaですよ"
        fill_in "メモ", with: "rubyのことがよくわかりますよ！"
        click_button "更新する"

        assert_text "Bookを更新しました！"
        assert_text "Ruby超入門ですよ"
        assert_text "igaigaですよ"
        assert_text "rubyのことがよくわかりますよ！"
      end
      
      it "本を削除する(destroy_book)" do 
        visit "ja"
        click_on "削除" 
        #ここでポップアップが出てくるところがうまく表現できてない。okボタンがテストで押せない為先に進まずエラー。
         page.accept_confirm do
           click_on "OK"
         end
        assert_text "Bookを削除しました！"
      end
    end    
  end
end