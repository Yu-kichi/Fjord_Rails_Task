# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @time = Time.now
    if params[:user_id]
      @user = User.find(params[:user_id]) # これで現在ログイン中の自分のものが表示できる。
      @reports = @user.reports.page(params[:page]).recent.per(Constants::DISPLAYABLE_USER_SIZE)
    else
      @reports = Report.includes(:user).page(params[:page]).recent.per(Constants::DISPLAYABLE_USER_SIZE)
    end
  end

  def show
    @user = @report.user
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("flash.create")
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("flash.update")
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, alert: t("flash.destroy")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :body,)
    end

    def correct_user
      redirect_to(root_url)  unless current_user.id == @report.user.id
    end
end
