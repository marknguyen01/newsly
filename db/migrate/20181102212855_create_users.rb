class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :points, :default => 0;
      t.timestamps
    end
    add_index :users, :email
    add_index :users, :username
    add_index :users, [:email, :username], unique: true
  end
end
