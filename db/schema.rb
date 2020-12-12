# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_12_224555) do

  create_table "directions", force: :cascade do |t|
    t.string "content"
    t.integer "recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "content"
    t.integer "recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "chef"
    t.string "cook_time"
    t.string "yield"
    t.string "directions"
    t.integer "user_id"
    t.string "ingredients"
    t.string "plain_directions"
    t.string "plain_ingredients"
  end

  create_table "sub_recipes", force: :cascade do |t|
    t.string "name"
    t.integer "recipe_id"
    t.string "directions"
    t.string "ingredients"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
  end

end
