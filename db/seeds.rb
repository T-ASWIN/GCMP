# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# 1. Find or create a Doctor/Provider
doctor = User.find_or_create_by!(email: 'admin@gmail.com') do |u|
  u.password = 'Password123'
  u.role = :admin # or :user depending on your logic
  u.status = :active
end

puts "Generating slots for Dr. Sarah Johnson..."

# 2. Configuration
target_date = Date.parse('2026-02-12') # Date from your UI image
start_hour = 9  # 09:00 AM
end_hour = 17   # 05:00 PM
interval = 30.minutes

# 3. Clear existing slots for this day if you want a fresh start
doctor.slot_schedules.where(date: target_date).destroy_all

# 4. Generation Loop
current_time = target_date.to_time.change(hour: start_hour)
end_time = target_date.to_time.change(hour: end_hour)

while current_time < end_time
  slot_end = current_time + interval
  
  # Randomly assign status to match your UI's mix of available/blocked
  # In a real app, you'd probably default to :available
  random_status = [0, 1].sample 

  SlotSchedule.create!(
    user: doctor,
    date: target_date,
    start_time: current_time.strftime("%H:%M"),
    end_time: slot_end.strftime("%H:%M"),
    status: random_status
  )
  
  current_time = slot_end
end

puts "Created #{doctor.slot_schedules.where(date: target_date).count} slots for #{target_date}."