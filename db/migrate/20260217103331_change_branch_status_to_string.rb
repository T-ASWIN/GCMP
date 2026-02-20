class ChangeBranchStatusToString < ActiveRecord::Migration[8.1]
  def up
    change_column_default :branches, :status, nil

       change_column :branches, :status, :string,
      using: "CASE WHEN status = 0 THEN 'active' ELSE 'inactive' END"

    change_column_default :branches, :status, 'active'
  end

  def down
    change_column_default :branches, :status, nil

    change_column :branches, :status, :integer,
      using: "CASE WHEN status = 'active' THEN 0 ELSE 1 END"

    change_column_default :branches, :status, 0
  end
end
