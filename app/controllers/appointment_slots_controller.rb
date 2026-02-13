class AppointmentSlotsController < ApplicationController
before_action :authenticate_user!

  def index
  @user = current_user
    @selected_date = params[:date] || Date.today.to_s

    all_slots = @user.slot_schedules.where(date: @selected_date).order(:start_time)

    @pagy, @paginated_slots = pagy(all_slots, limit: 8)
  end
  
  def slot_update
  @slot = current_user.slot_schedules.find(params[:id])

  if @slot.available?
    @slot.blocked!   
  else
    @slot.available! 
  end
end
end