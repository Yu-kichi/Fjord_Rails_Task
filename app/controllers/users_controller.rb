# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update ]
  before_action :set_locale
  before_action :correct_user, only: %i[edit update ]

  def index
    @users = User.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
    @time = Time.now
  end

  def show
    @book_count = @user.books.size
    @books = @user.books
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t("flash.update")
    else
      render :edit
    end
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings.with_attached_portrait.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
    #下のような.recentがこのままだと使えない。
    #@users = user.includes([:portrait_attachment]).page(params[:page]).recent.per(Constants::DISPLAYABLE_USER_SIZE)
    #これだとN+１は起きないが全ユーザーを取得してしまう。。ユーザー一覧ページならおk
    #@users = User.with_attached_portrait
  end

  def followers
    user = User.find(params[:id])
    #@users = user.followers
    @users = user.followers.with_attached_portrait.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :zip_code, :address, :introduction, :portrait)
    end

    def correct_user
      redirect_to root_url unless current_user.id == @user.id
    end
end
