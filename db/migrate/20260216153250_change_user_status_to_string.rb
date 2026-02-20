class ChangeUserStatusToString < ActiveRecord::Migration[8.1]
  def up
    change_column_default :users, :status, nil

      change_column :users, :status, :string,
      using: "CASE WHEN status = 0 THEN 'active' ELSE 'inactive' END"

    change_column_default :users, :status, 'active'
  end

  def down
    change_column_default :users, :status, nil

    change_column :users, :status, :integer,
      using: "CASE WHEN status = 'active' THEN 0 ELSE 1 END"

    change_column_default :users, :status, 0
  end
end
