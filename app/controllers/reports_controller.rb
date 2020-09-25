# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  def index
    @time = Time.now
    if params[:user_id]
      @user = User.find(params[:user_id]) #これで特定のユーザーのもののみを表示できる。
      @reports = @user.reports.page(params[:page]).order_by_recent.per(Constants::DISPLAYABLE_USER_SIZE)
    else
      @reports = Report.includes(:user).page(params[:page]).order_by_recent.per(Constants::DISPLAYABLE_USER_SIZE)
    end
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("flash.create",model: Report)
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("flash.update",model: Report)
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, alert: t("flash.destroy",model: Report)
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :body,)
    end

    def correct_author
      redirect_to(root_url)  unless current_user.id == @report.user.id
    end
end
