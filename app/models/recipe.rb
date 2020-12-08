class Recipe < ActiveRecord::Base
    has_many :ingredients
    has_many :sub_recipes
end