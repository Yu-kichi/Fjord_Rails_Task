# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_locale
  before_action :honnin?, only: %i[edit update destroy]
  # skip_before_action :authenticate_user!, only: :show これで書き方はあってることを確認。

  def index
    @users = User.page(params[:page]).per(10)#マジックナンバーになる。。
    @time = Time.now
  end

  def show
    #@book_count = @user.books.size
  end

  def edit
    # @user = User.find(params[:id])
    # redirect_to(root_url) unless @user == current_user
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t("directory.flash.update")
    else
      render :edit
    end
  end
  # 一応作っとくが管理者以外使えないようにする。
  def destroy
    @user.destroy
    redirect_to users_url, alert: t("directory.flash.destroy")
  end

  private
    def honnin?
      # redirect_to root_url,notice: t("directory.flash.update") unless @user == current_user
      redirect_to root_url, alert: "本人以外はできません" unless @user == current_user # これでdestroyもリダイレクトできる。
    end
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :zip_code, :address, :introduction)
    end
end