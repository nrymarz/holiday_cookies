class CreateSubRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_recipes do |t|
      t.string :name
      t.integer :recipe_id
      t.string :directions
    end
  end
end
