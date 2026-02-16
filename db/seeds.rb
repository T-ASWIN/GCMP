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

user = User.find_or_create_by!(email: 'user@gmail.com') do |u|
  u.password = 'Welcome@123'
  u.role = :admin
  u.status = :active
end

puts "Generating slots"

target_date = Date.parse('2026-02-17') 
start_hour = 9  
end_hour = 17  
interval = 30.minutes


current_time = target_date.to_time.change(hour: start_hour)
end_time = target_date.to_time.change(hour: end_hour)

while current_time < end_time
  slot_end = current_time + interval
  
  random_status = [:available, :blocked].sample 

  SlotSchedule.find_or_create_by!(
    user: user,
    date: target_date,
    start_time: current_time.strftime("%H:%M")
  ) do |slot|
    slot.end_time = slot_end.strftime("%H:%M")
    slot.status = [:available, :blocked].sample 
  end
  
  current_time = slot_end
end

puts "Created #{user.slot_schedules.where(date: target_date).count} slots for #{target_date}."