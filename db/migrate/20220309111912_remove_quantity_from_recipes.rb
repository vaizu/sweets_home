class RemoveQuantityFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :quantity, :string
  end
end
