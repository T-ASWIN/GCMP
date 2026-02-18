class AppointmentSlotsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = AppointmentSlots::FetchAppointmentSlots.run(
    user: current_user, 
    params: params.to_unsafe_h
    )

     if result.valid?
       @slots_result = result.result[:slots_result]
       @q = result.result[:q]
       @selected_date = result.result[:selected_date]
       @pagy, @paginated_slots = pagy(:offset, @slots_result, page: params[:page], items: params[:per_page] || 8)
     end
  end

  def slot_update
    @slot = SlotSchedule.find(params[:id])

    authorize @slot, :update? 

    @slot.toggle_availability!
    render json: { status: 'success' }, status: :ok
  end
end