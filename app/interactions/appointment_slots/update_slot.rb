  class AppointmentSlots::UpdateSlotAvailability < ActiveInteraction::Base
    object :slot, class: SlotSchedule
    
    def execute
      new_status = !slot.available? 
      
      if slot.update(available: new_status)
        slot
      else
        errors.merge!(slot.errors)
      end
    end
  end