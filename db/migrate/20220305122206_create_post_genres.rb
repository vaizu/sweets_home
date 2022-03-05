class CreatePostGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :post_genres do |t|
      t.integer :post_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
