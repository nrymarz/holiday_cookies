class Scraper
    def self.make_doc(url)
        Nokogiri::HTML(URI.open(url))
    end

    def self.call
        url = "https://www.foodnetwork.com/search/holiday-/CUSTOM_FACET:RECIPE_FACET/DISH_DFACET:0/tag%23dish:cookie"
        recipe_docs = find_recipes(url)
        recipe_hashes = build_recipe_hashes(recipe_docs)
        recipe_hashes.each do |recipe|
            recipe[:recipe].delete(:link)
            sub_recipes = recipe[:recipe][:sub_recipes].collect do |subrecipe|
                new_subrecipe = SubRecipe.create(name: subrecipe[:name])
                add_directions_and_ingredients(subrecipe[:ingredients],subrecipe[:directions],new_subrecipe)
            end
            recipe[:recipe][:sub_recipes] = sub_recipes
            new_recipe = Recipe.create(recipe[:recipe])
            add_directions_and_ingredients(recipe[:ingredients],recipe[:directions],new_recipe)
        end
    end

    def self.add_directions_and_ingredients(ingredients,directions,recipe)
        ingredients.each do |ingredient|
            new_ingredient = Ingredient.create(content: ingredient)
            recipe.ingredients << new_ingredient
        end
        directions.each do |direction|
            new_direction = Direction.create(content: direction)
            recipe.directions << new_direction
        end
        recipe.save
        recipe
    end

    def self.build_recipe_hashes(recipe_docs)
        recipe_hashes = recipe_docs.collect do |recipe|
            {
                name: recipe.css('.m-MediaBlock__a-HeadlineText').text,
                chef: recipe.css('.m-Info__a-AssetInfo').text.delete_prefix('Courtesy of '),
                link: 'https:'.concat(recipe.css('.m-MediaBlock__a-Headline a')[0]['href'])
            } 
        end
        recipe_hashes.collect do |recipe|
            recipe_info = get_recipe_info(recipe[:link])
            recipe_info[:recipe].merge!(recipe)
            recipe_info
        end
    end

    def self.find_recipes(url)
        doc = make_doc(url)
        recipe_list = doc.css('.o-RecipeResult')
    end

    def self.get_recipe_info(url)
        doc = make_doc(url)
        ingredients = get_ingredients_list(doc)
        total_cook_time = doc.css('span.m-RecipeInfo__a-Description--Total')[0]
        active_cook_time = doc.css("ul.o-RecipeInfo__m-Time span.o-RecipeInfo__a-Description")[1]
        yeld = doc.css("ul.o-RecipeInfo__m-Yield span.o-RecipeInfo__a-Description")[0]
        sub_recipes = get_subrecipes(doc)
        directions = get_directions(doc)
        {
            ingredients: ingredients,
            recipe: {
                cook_time: total_cook_time ? total_cook_time.text.strip : 'n/a',
                yield: yeld ? yeld.text : 'n/a',
                sub_recipes: sub_recipes
            },
            directions: directions
        }
    end

    def self.add_recipe_attributes(recipe)
        attributes =  get_recipe_info(recipe.link)
        recipe.add_attributes(attributes)
    end

    def self.get_directions(doc,subrecipe=nil)
        if subrecipe
            subheaders = doc.css('h4.o-Method__a-SubHeadline')
            directions = subheaders.detect{|subhead| subhead.text.strip == subrecipe.text.strip}
        else
            directions = doc.css("ol")
        end
        if subrecipe && directions
            until directions.name == 'ol'
                directions = directions.next_element
            end
            directions.css('li.o-Method__m-Step').collect {|direction| direction.text.strip}
        elsif directions && !subrecipe
            directions[0].css('li.o-Method__m-Step').collect {|direction| direction.text.strip}
        else
            []
        end
    end

    def self.get_subrecipes(doc)
        sub_recipes = doc.css(".o-Ingredients__a-SubHeadline")
        sub_recipes.collect do |recipe|
            {
                name: recipe.text.strip.chomp(':'),
                ingredients: self.get_ingredients_list(doc,recipe),
                directions: self.get_directions(doc,recipe)
            }
        end
    end

    def self.get_ingredients_list(doc,subrecipe = nil)
        subrecipe ? element = subrecipe : element = doc.css('p.o-Ingredients__a-Ingredient')[0]
        ingredients = []
        if element
            while(element.next_element && element.next_element.attributes['class'].value == "o-Ingredients__a-Ingredient")
                ingredients << element.next_element.text.strip
                element = element.next_element
            end
        end
        ingredients
    end

    def self.get_next_page(url)
        page = url.match(/\/p\/\d+/)
        if page
            page = page.to_s.delete_prefix('/p/').to_i 
            url.gsub(/\/p\/\d+/,"/p/#{page+1}")
        else
            url = url.split('/CUSTOM')
            url[0].concat('/p/2/CUSTOM')
            url.join
        end
    end
end