require 'rails_helper'

RSpec.describe User, type: :model do

  it "editable?(current_user)" do
    tom = User.create(name:"tom",email:"tom@example.com" ,password: "password",uid: "23456678")
    book1 = Book.create(title: "よくわかるGit")
    alice = FactoryBot.create(:user)
    #book2  = FactoryBot.create(:book)

    #下のようなvisitなどは使えない
    # visit new_user_session_path
    # fill_in "Eメール", with: "alice@example.com"
    # fill_in "パスワード", with: "password"
    # click_button "ログイン"
    #どうやってログインユーザーを使えるようにするか？？
    aseert current_user == book1.user
  end


end
