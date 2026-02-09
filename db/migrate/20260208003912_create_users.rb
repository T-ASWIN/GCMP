class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :unique_id, null: false
      t.string :name
      t.string :email, null: false
      t.string :password_digest,null: false
      t.integer :role, default: 1
      t.integer :status, default: 1

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :unique_id, unique: true
  end
end
