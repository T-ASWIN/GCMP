class ChangeUserRoleToString < ActiveRecord::Migration[8.1]
  def up
    change_column_default :users, :role, nil

    change_column :users, :role, :string,
      using: "CASE WHEN role = 0 THEN 'user' WHEN role = 1 THEN 'admin' ELSE 'user' END"

    change_column_default :users, :role, 'user'
  end

  def down
    change_column_default :users, :role, nil

    change_column :users, :role, :integer,
      using: "CASE WHEN role = 'user' THEN 0 WHEN role = 'admin' THEN 1 END"

    change_column_default :users, :role, 0
  end
end
