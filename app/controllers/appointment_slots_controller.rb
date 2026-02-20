class AppointmentSlotsController < ApplicationController
  before_action :authenticate_user!

  def index
  scoped_slots = policy_scope(SlotSchedule)

  result = AppointmentSlots::AppointmentSlots.run(
    user: current_user,
    scope: scoped_slots,
    params: appointment_params
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

  result = AppointmentSlots::UpdateSlotAvailability.run(slot: @slot)

     if result.valid?
       render json: { 
        status: "success", 
        available: result.result.available? 
        }, status: :ok
    else
      render json: { 
      errors: result.errors.full_messages 
      }, status: :unprocessable_entity
    end
end

  private

  def appointment_params
    params.permit(:date, :page, :per_page, q: {})
  end
end
