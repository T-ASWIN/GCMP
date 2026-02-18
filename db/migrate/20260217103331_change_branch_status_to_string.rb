class ChangeBranchStatusToString < ActiveRecord::Migration[8.1]
  def up
    # 1. Remove the default temporarily
    change_column_default :branches, :status, nil

    # 2. Change column to string with explicit conversion
    # 0 -> 'active', everything else -> 'inactive'
    change_column :branches, :status, :string, 
      using: "CASE WHEN status = 0 THEN 'active' ELSE 'inactive' END"

    # 3. Apply the new string-based default
    change_column_default :branches, :status, 'active'
  end

  def down
    change_column_default :branches, :status, nil
    
    change_column :branches, :status, :integer, 
      using: "CASE WHEN status = 'active' THEN 0 ELSE 1 END"
      
    change_column_default :branches, :status, 0
  end
end