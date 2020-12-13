class DeleteIngredientsDirectionsFromRecipesAndSubrecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :ingredients
    remove_column :recipes, :directions
    remove_column :sub_recipes, :directions
    remove_column :sub_recipes, :ingredients
  end
end
