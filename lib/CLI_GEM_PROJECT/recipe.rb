class Recipe
    attr_accessor :name, :category, :ingredients, :directions, :url

    def self.create_recipe(link)
        html = open("#{link}")
        doc = Nokogiri::HTML(html)
        new_recipe = self.new
        new_recipe.name = doc.css(".summary-background .recipe-summary.clearfix h1").text
        new_recipe.url = link
        new_recipe.ingredients = doc.css("div #polaris-app .checklist__line").each_with_index do |item, i|
            if i == 0
                puts "INGREDIENTS:"
                puts item.css("li label span .recipe-ingred_txt.added").text.strip
            else
                puts item.css("li label span .recipe-ingred_txt.added").text.strip
            end
        end
        
        new_recipe.directions = doc.css("div .directions--section .directions--section__steps ng-scope .list-numbers recipe-directions__list li").each_with_index do |item, i|
            if i == 0
                puts "DIRECTIONS:"
                puts item.css(".recipe-directions__list--item").text.strip
            else
                puts item.css(".recipe-directions__list--item").text.strip
            end
        end
        puts new_recipe.name
        puts ""
        puts new_recipe.category
        puts ""
        puts new_recipe.ingredients
        puts ""
        puts new_recipe.directions
    end
end