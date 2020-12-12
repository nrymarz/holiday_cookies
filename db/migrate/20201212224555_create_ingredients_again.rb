class CreateIngredientsAgain < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :content
      t.integer :recipe_id
    end
  end
end
