# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @books = @user.books
    else
      @books = Book.includes(:user)
    end
    @books = @books.order_by_recent.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
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
      redirect_to @book, notice: t("flash.create", model: Book.model_name.human)
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("flash.update", model: Book.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, alert: t("flash.destroy", model: Book.model_name.human)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end

    def correct_author
      redirect_to(root_url)  unless current_user.id == @book.user.id
    end
end
