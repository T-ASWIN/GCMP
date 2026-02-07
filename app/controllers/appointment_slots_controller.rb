class AppointmentSlotsController < ApplicationController
  def index
    # Use randomized data if a date is present, otherwise use default data
    @slots = generate_slots(params[:date])

    respond_to do |format|
      format.html # Normal page load
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("slotsContainer", 
               partial: "appointment_slots/slots_grid", 
               locals: { slots: @slots })
      end
    end
  end

  private

  def generate_slots(date)
    times = ["09:00 - 09:30", "09:30 - 10:00", "10:00 - 10:30", "10:30 - 11:00", 
             "11:00 - 11:30", "11:30 - 12:00", "12:00 - 12:30", "12:30 - 01:00", 
             "02:00 - 02:30", "02:30 - 03:00", "03:00 - 03:30", "03:30 - 04:00", 
             "04:00 - 04:30", "04:30 - 05:00"]
             
    times.map do |t|
      { t: t, s: ["available", "blocked"].sample }
    end
  end
end