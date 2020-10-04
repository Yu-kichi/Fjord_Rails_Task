require "rails_helper"

describe "comment投稿機能", type: :system do
  before do 
    Bob = FactoryBot.create(:user, name: "Bob",email: "bob@example.com", password: "password", uid:"bobtest")
    FactoryBot.create(:book)
    #下のはすでに同じユーザーがいるというエラーになる
    #FactoryBot.create(:comment)
    #FactoryBot.create(:report)
  end

  before do 
    visit new_user_session_path
    fill_in "Eメール", with: "bob@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end
  
  it "コメントの確認(show)" do 
    visit root_path
    click_on "詳細"
    expect(page).to have_content "コメントを投稿する"
  end
  
  it "コメントを新規投稿する(create_comment)" do 
    visit root_path
    click_on "詳細"

    fill_in "comment_body", with: "大変参考になりました"
    expect{click_button "登録する"}.to change{ Comment.count }.by(1)
    assert_text "コメントを作成しました！"
    assert_text "大変参考になりました"
  end
  context "ユーザーBobがログインしている時" do 
    before do
      visit root_path
      click_on "詳細"
      fill_in "comment_body", with: "大変参考になりました"
      click_button "登録する"
    end

    it "Aliceの本の投稿に対するBobのコメントの編集をする(update_comment)" do 
      visit root_path
      click_on "詳細"
      click_on "編集"
  
      fill_in "コメント", with: "めっちゃ面白い"
      click_button "更新する"
  
      assert_text "コメントを更新しました！"
      assert_text "めっちゃ面白い"
    end

    it "コメントを削除する(destroy_comment)" do 
      visit root_path
      click_on "詳細"
      click_on "削除"
      expect{
        page.accept_confirm "本当に削除しますか？"
        expect(page).to have_content "コメントを削除しました！"
      }.to change { Comment.count }.by(-1)
    end
  end
end