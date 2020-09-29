# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :correct_author, only: %i[edit update destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @reports = @user.reports
    else
      @reports = Report.includes(:user)
    end
    @reports = @reports.order_by_recent.page(params[:page]).per(Constants::DISPLAYABLE_USER_SIZE)
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
      redirect_to @report, notice: t("flash.create", model: Report.model_name.human)
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("flash.update", model: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, alert: t("flash.destroy", model: Report.model_name.human)
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
