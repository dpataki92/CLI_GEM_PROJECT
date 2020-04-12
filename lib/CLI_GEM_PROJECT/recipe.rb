class Recipe
    attr_accessor :name, :diet, :cook_time, :ingredients, :directions, :url

    def self.create_multiple_recipes(link)
        doc = Nokogiri::HTML(open("#{link}"))
        doc.css(".grd-tile-detail .grd-title-link a").collect do |a|
            link = a["href"] 
            recipe = self.create_recipe(link)
            recipe
        end
    end

    def self.create_recipe(link)
        doc = Nokogiri::HTML(open("#{link}"))
        recipe = self.new
        recipe.name = doc.css(".entry-title").text.strip
        recipe.cook_time = doc.css(".cooktime").text.strip
        recipe.diet = doc.css(".taxonomy-term.button-action span").select {|sp| sp.text == "Gluten-Free" || sp.text == "Vegetarian"}.collect do{|el| el.text.downcase}.uniq.join(",")
        recipe.ingredients = doc.css(".ingredient").text.strip
        recipe.directions = doc.css(".entry-details.recipe-method.instructions div p").collect {|p| p.text.strip}
        recipe.url = "#{link}"
        recipe
    end
end