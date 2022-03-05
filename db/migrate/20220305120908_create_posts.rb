class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :post_name, null: false
      t.text :post_introduction
      t.integer :cooking_time
      t.integer :cooking_cost

      t.timestamps
    end
  end
end
