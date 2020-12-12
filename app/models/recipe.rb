class Recipe < ActiveRecord::Base
    has_many :ingredients
    has_many :directions
    has_many :sub_recipes
    belongs_to :user
    def slug
        self.name.gsub(/[\s#$%()?'\.]/,'-')
    end

    def self.find_by_slug(slug)
        self.all.find{|recipe| recipe.slug == slug}
    end
end