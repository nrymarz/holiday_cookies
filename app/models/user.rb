class User < ActiveRecord::Base
    has_many :recipes
    def slug
        self.name.gsub(/[\s#$%()?\.]/,'-')
    end

    def self.find_by_slug(slug)
        self.all.find{|recipe| recipe.slug == slug}
    end
end