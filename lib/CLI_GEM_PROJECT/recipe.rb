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
        if list_return.class == Array
            list_return.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        else
        method(list_return).call.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        end
    end

    def self.find_by_diet(list_return)
        puts "Type 'v' if you are only interested in the vegetarian dishes"
        puts "Type 'g' if you are only interested in the gluten-free dishes"
        input = gets.strip.downcase
        if input == "v"
            method(list_return).call.select {|dish| dish.diet.include?("vegetarian")}
        elsif input == "g"
            method(list_return).call.select {|dish| dish.diet.include?("gluten-free")}
        end
    end

    def self.format_recipe(obj)
        puts ""
        puts "*** #{obj.name} ***"
        puts ""
        puts "Average cook time is: #{obj.cook_time}"
        puts "Categories: #{obj.diet}" if obj.diet
        puts ""
        puts "INGREDIENTS:"
        obj.ingredients.each {|ing| puts "- #{ing}"}
        puts ""
        puts "DIRECTIONS:"
        obj.directions.each {|dir| puts "- #{dir}"}
        puts ""
        puts "If you want to know more, check out this: #{obj.url}"
        puts ""
        puts "Bon Appetit!"
        puts ""
    end

    def self.return_recipe(arr)
        puts "Select a meal by number"
        input = gets.strip
        self.format_recipe(arr[input.to_i - 1])
    end

end