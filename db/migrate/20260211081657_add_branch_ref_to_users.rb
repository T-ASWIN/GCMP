class AddBranchRefToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :branch, null: false, foreign_key: true
  end
end
