class CreateBranches < ActiveRecord::Migration[8.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :capacity

      t.timestamps
    end
  end
end
