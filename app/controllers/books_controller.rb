# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @time = Time.now
    if params[:user_id]
      @user = User.find(params[:user_id]) # これで現在ログイン中の自分のものが表示できる。
      @books = @user.books.page(params[:page]).recent.per(Constants::DISPLAYABLE_USER_SIZE)
    else
      @books = Book.includes(:user).page(params[:page]).recent.per(Constants::DISPLAYABLE_USER_SIZE)
    end
  end

  def show
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book, notice: t("flash.create")
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("flash.update")
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, alert: t("flash.destroy")
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end

    def correct_user
      redirect_to(root_url)  unless current_user.id == @book.user.id
    end
end
