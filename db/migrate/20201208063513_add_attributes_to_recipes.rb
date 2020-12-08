class AddAttributesToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :cook_time, :string
    add_column :recipes, :yield, :string
    add_column :recipes, :directions, :string
  end
end
