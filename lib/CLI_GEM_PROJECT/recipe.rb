class Recipe
    attr_accessor :name, :diet, :cook_time, :ingredients, :directions, :url

    @@all = {
        breakfast: nil,
        lunch: nil,
        dinner: nil
    }

    def self.save_all
        @@all[:breakfast] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/breakfast_and_brunch/")
        @@all[:lunch] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/lunch/")
        @@all[:dinner] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/dinner/")
    end

    def self.all
        @@all
    end

    def self.return_all
        self.all.values.flatten
    end

    def self.all_breakfast
        self.all[:breakfast]
    end

    def self.all_lunch
        self.all[:lunch]
    end

    def self.all_dinner
        self.all[:dinner]
    end

    def self.print_list(list_return)
        method(list_return).call.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
    end

    def self.find_by_diet(list_return)
        puts "Type 'v' if you are only interested in the vegetarian dishes"
        puts "Type 'g' if you are only interested in the gluten-free dishes"
        input = gets.strip.downcase
        if input == "v"
            method(list_return).call.select {|dish| dish.diet.include?("vegetarian")}.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        elsif input == "g"
            method(list_return).call.select {|dish| dish.diet.include?("gluten-free")}.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        end
    end

end