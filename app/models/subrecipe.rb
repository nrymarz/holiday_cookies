class SubRecipe < ActiveRecord::Base
    has_many :ingredients
    has_many :directions
    belongs_to :recipe
end