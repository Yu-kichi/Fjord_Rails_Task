# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update followings followers]
  before_action :set_locale
  before_action :correct_user, only: %i[edit update ]

  def index
    @users = User.order_by_recent.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
    @time = Time.now
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t("flash.update", model: User)
    else
      render :edit
    end
  end

  def followings
    @users = @user.followings.with_attached_portrait.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
  end

  def followers
    @users = @user.followers.with_attached_portrait.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
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
