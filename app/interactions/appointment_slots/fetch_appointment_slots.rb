  class AppointmentSlots::FetchAppointmentSlots < ActiveInteraction::Base
    object :user
    # Allow params to be a hash (ActionController::Parameters)
    hash :params, strip: false 

    def execute
      base_scope = SlotSchedule.includes(:user)

      if user.admin?
        # Handle Admin Logic
        q = base_scope.ransack(params[:q])
        { 
          slots_result: q.result(distinct: true), 
          q: q 
        }
      else
        # Handle User Logic
        selected_date = params[:date] || Date.today.to_s
        slots_result = base_scope.where(user_id: user.id, date: selected_date)
                                 .order(:start_time)
        { 
          slots_result: slots_result, 
          selected_date: selected_date 
        }
      end
    end
  end