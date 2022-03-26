class AddQuantityToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :quantity, :string
  end
end
