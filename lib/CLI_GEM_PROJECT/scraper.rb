class Scraper

    def self.create_recipe(link)
        doc = Nokogiri::HTML(open("#{link}"))
        recipe = Recipe.new
        recipe.name = doc.css(".entry-title").text.strip
        recipe.cook_time = doc.css(".cooktime").text.strip
        recipe.diet = doc.css(".taxonomy-term.button-action span").select {|sp| sp.text == "Gluten-Free" || sp.text == "Vegetarian"}.collect {|el| el.text.downcase}.uniq.join(",")
        recipe.ingredients = doc.css(".ingredient").collect {|ingredient| ingredient.text.strip}.reject {|el| el.empty?}
        recipe.directions = doc.css(".entry-details.recipe-method.instructions div p").collect {|p| p.text.strip}.reject {|el| el.empty?}
        recipe.url = "#{link}"
        recipe
    end

    def self.create_recipes_from_course_page(link)
        doc = Nokogiri::HTML(open("#{link}"))
        doc.css(".grd-tile-detail .grd-title-link a").collect do |a|
            link = a["href"] 
            recipe = self.create_recipe(link)
            recipe
        end
    end

end