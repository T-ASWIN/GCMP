class Admin::AppointmentSlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!


def index
  @q = SlotSchedule.joins(:user).ransack(params[:q])
  @slots = @q.result.includes(:user)

  @pagy, @slots = pagy(@slots.order(:date, :start_time), limit: 8)
end

  private

  def authorize_admin!
    redirect_to user_root_path, alert: "Access denied" unless current_user.admin?
  end
end
