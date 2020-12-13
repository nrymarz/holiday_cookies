class AddSubrecipesToIngredientsAndDirections < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :sub_recipe_id, :integer
    add_column :directions, :sub_recipe_id, :integer
  end
end
