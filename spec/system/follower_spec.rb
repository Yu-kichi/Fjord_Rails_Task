require "rails_helper"

describe "follower登録機能", type: :system do
  before do 
    Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid: "bobtest",zip_code:"2345678",address: "鳥取",introduction:"like sushi")
    Alice = FactoryBot.create(:user)
  end
  context "ユーザーBobがログインしている時" do 
    before do 
      visit new_user_session_path
      fill_in "Eメール", with: "bob@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end
    it "フォローする(create)" do
      visit root_path
      click_on "ユーザー"
      click_on "Alice"
      expect{click_on "フォローする"}.to change {FollowFollower.count }.by(1)
    end
    #この書き方だと入れ子になってるので修正する！
    context "ユーザーBobがAliceをフォローしている時" do 
      before do
        visit root_path
        click_on "ユーザー"
        click_on "Alice"
        click_on "フォローする"
      end
     
      it "フォローを外す(destroy)" do
        visit root_path
        click_on "ユーザー"
        click_on "Alice"
        expect{click_on "フォロー中"}.to change {FollowFollower.count }.by(-1)
      end
    end
  end
end