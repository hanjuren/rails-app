class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.string :thumb_nail_image_src

      t.timestamps
    end
  end
end
