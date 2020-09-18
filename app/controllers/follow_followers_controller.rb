# frozen_string_literal: true

class FollowFollowersController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    if follow.save
      redirect_to user_path(params[:user_id])
    else
      redirect_to user_path(params[:user_id]), alert: t("flash.failure")
    end
  end

  def destroy
    follow = current_user.active_relationships.find_by!(follower_id: params[:user_id])
    follow.destroy
    redirect_to user_path(params[:user_id])
  end
end
