class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|

      t.integer :post_id
      t.string :meterial, null: false
      t.text :recipe, null: false

      t.timestamps
    end
  end
end
