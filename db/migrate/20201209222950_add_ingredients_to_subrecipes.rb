class AddIngredientsToSubrecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :sub_recipes, :ingredients, :string
  end
end
