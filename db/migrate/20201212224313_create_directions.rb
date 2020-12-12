class CreateDirections < ActiveRecord::Migration[6.0]
  def change
    create_table :directions do |t|
      t.string :content
      t.integer :recipe_id
    end
  end
end
