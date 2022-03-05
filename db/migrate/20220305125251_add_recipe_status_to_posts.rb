class AddRecipeStatusToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :recipe_status, :integer
  end
end
