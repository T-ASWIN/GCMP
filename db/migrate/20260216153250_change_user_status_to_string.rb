class ChangeUserStatusToString < ActiveRecord::Migration[8.1]
  def up
    # 1. Remove the default temporarily to avoid type conflicts during conversion
    change_column_default :users, :status, nil

    # 2. Change column to string with explicit conversion logic
    # This converts 0 -> 'active' and anything else (like 1) -> 'inactive'
    change_column :users, :status, :string, 
      using: "CASE WHEN status = 0 THEN 'active' ELSE 'inactive' END"

    # 3. Apply the new string-based default
    change_column_default :users, :status, 'active'
  end

  def down
    # How to go back: Convert strings back to integers
    change_column_default :users, :status, nil
    
    change_column :users, :status, :integer, 
      using: "CASE WHEN status = 'active' THEN 0 ELSE 1 END"
      
    change_column_default :users, :status, 0
  end
end