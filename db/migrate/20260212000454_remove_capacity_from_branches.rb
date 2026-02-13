class RemoveCapacityFromBranches < ActiveRecord::Migration[8.1]
  def change
    remove_column :branches, :capacity, :integer
  end
end
