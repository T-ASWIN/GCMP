class AppointmentSlots::FetchAppointmentSlots < ActiveInteraction::Base
  object :user
  interface :scope, methods: [:where, :includes] 
  hash :params, default: {}, strip: false

  def execute
    user_scope = scope.includes(:user)

    if user.admin?
      q = user_scope.ransack(params[:q])
      {
        slots_result: q.result(distinct: true),
        q: q
      }
    else
      selected_date = params[:date] || Date.today.to_s
      {
        slots_result: user_scope.where(date: selected_date).order(:start_time),
        selected_date: selected_date
      }
    end
  end
end