class AddColumnsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :post_id, :integer
    add_column :recipes, :meterial, :string
    add_column :recipes, :recipe, :text
  end
end
