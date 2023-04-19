class AddSocialColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uid, :bigint
    add_column :users, :provider, :string
    add_column :users, :nick_name, :string
    add_column :users, :name, :string
    add_column :users, :phone, :string

    add_index :users, :uid, unique: false
  end
end
