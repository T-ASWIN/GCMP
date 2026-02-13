class AddLocationToBranches < ActiveRecord::Migration[8.1]
  def change
    add_column :branches, :location, :string
  end
end
