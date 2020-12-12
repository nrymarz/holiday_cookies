class Direction < ActiveRecord::Base
    belongs_to :recipe 
    belongs_to :sub_recipe
end