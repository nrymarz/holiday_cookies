class AddRawTextDirectionsAndIngredientsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :plain_directions, :string
    add_column :recipes, :plain_ingredients, :string
  end
end
