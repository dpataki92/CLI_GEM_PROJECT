class Recipe
    attr_accessor :name, :categories, :cook_time, :ingredients, :directions, :url

    def self.create_recipes(link)
        html = open("#{link}")
        doc = Nokogiri::HTML(html)
        all_recipes = []
        doc.css(".grd-title-link a span").each {|recipe| all_recipes << recipe.text.strip}
        p all_recipes
    end

    def self.return_recipe(link)
        html = open("#{link}")
        doc = Nokogiri::HTML(html)
        recipe = self.new
        recipe.name = doc.css(".entry-title").text.strip
        recipe.cook_time = doc.css(".cooktime").text.strip
        recipe.ingredients = doc.css(".ingredient").text.strip
        recipe.directions = doc.css(".entry-details.recipe-method.instructions div p").collect {|p| p.text.strip}
        puts recipe.name
        puts recipe.cook_time
        puts recipe.ingredients
        puts recipe.directions
    end
end