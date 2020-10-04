require "rails_helper"

describe "user登録機能", type: :system do
  before do 
    Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid: "bobtest",zip_code:"2345678",address: "鳥取",introduction:"like sushi")
  end
  
  it "アカウント登録ページの表示(index)" do 
    visit new_user_registration_path
    expect(page).to have_content "アカウント登録"
  end

  it "新規投稿する(create_user)" do
    visit new_user_registration_path
    fill_in "名前", with: "allice"
    fill_in "Eメール", with: "allice@example.com"
    fill_in "パスワード", with: "password"
    #(確認用)が見つからないのでここだけfindを使う。
    find(:id, "confirm").set("password")
    expect{click_button "アカウント登録"}.to change{ User.count }.by(1)
  end
  
  context "ユーザーBobがログインしている時" do 
    before do 
      visit new_user_session_path
      fill_in "Eメール", with: "bob@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end
  
    it "ユーザー詳細を表示する (show)" do
      visit root_path
      click_on "Bob"
      assert_text "Bob"
      assert_text "bob@example.com"
      assert_text "2345678"
      assert_text "鳥取"
      assert_text "like sushi"
    end
    
    it "ユーザー情報の編集をする(update)" do
      visit root_path
      click_on "Bob"
      click_on "編集"

      fill_in "名前", with: "Charlie"
      fill_in "Eメール", with: "charlie@example.com"
      fill_in "住所", with: "イギリス"
      fill_in "郵便番号", with: "2345678"
      fill_in "自己紹介文", with: "Like Football"
      click_button "更新する"
      
      assert_text "Userを更新しました！"
      assert_text "Charlie"
      assert_text "charlie@example.com"
      assert_text "イギリス"
      assert_text "2345678"
      assert_text "Like Football"
    end

    it "ユーザーの削除(destroy)" do
      visit root_path
      click_on "Bob"
      click_on "パスワードを変更"
      click_on "アカウント削除"
      expect{
        page.accept_confirm "本当によろしいですか?"
        expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
      }.to change { User.count }.by(-1)
    end
  end
end