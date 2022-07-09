class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.text :title
      t.string :description
      t.string :author_name
      t.integer :publisher_id

      t.timestamps
    end

    add_index :books, :publisher_id, unique: false
  end
end
