# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def index
    @books = Book.all.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
    @time = Time.now
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, success: t("flash.create")
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, success: t("flash.update")
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, success: t("flash.destroy")
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
