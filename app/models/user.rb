class User < ActiveRecord::Base
    has_many :recipes
    has_secure_password
    validates :name, presence: true
    validates :name, uniqueness: true
    def slug
        self.name.gsub(/[\s#$%()?\.]/,'-')
    end

    def self.find_by_slug(slug)
        self.all.find{|recipe| recipe.slug == slug}
    end
end