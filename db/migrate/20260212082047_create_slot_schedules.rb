class CreateSlotSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :slot_schedules do |t|

      t.references :user, null: false, foreign_key: true
      
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      
      # Status as an integer for the Enum (available: 0, blocked: 1)
      t.integer :status, default: 0, null: false
      t.timestamps
    end

    add_index :slot_schedules, [:user_id, :date]

    add_index :slot_schedules, [:user_id, :date, :start_time], unique: true, name: 'idx_unique_user_slot'
  end
end
