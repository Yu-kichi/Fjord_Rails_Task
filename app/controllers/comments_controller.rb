# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :correct_author, only: [:edit, :update, :destroy]

  def new
    @comment = @commentable.comments.build
  end

  def edit
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @commentable, notice: t("flash.create", model: Comment)
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t("flash.update", model: Comment)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable,  alert: t("flash.destroy", model: Comment)
  end

  private
    def set_commentable
      _locale, resource, id = request.path.split("/")[1, 3]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def correct_author
      redirect_to(root_url)  unless current_user.id == @comment.user.id
    end
end
