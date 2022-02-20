class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :access_token
      t.string :refresh_token
      t.string :name
      t.string :nick_name
      t.integer :age
      t.string :gender
      t.datetime :last_sign_in_at
      t.datetime :last_sign_out_at

      t.timestamps
    end
    add_index :users, :name, unique: false
  end
end
