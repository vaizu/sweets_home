class RemoveMeterialFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :meterial, :string
  end
end
