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
        if list_return.instance_of? Array
            list_return.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        else
        method(list_return).call.each_with_index {|el, i| puts "#{i+1}. #{el.name}"}
        end
    end

    def self.find_by_diet(list_return, input)
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

    def self.return_recipe(list_return, input)
        if list_return.instance_of? Array
            self.format_recipe(list_return[input.to_i - 1])
        else
            self.format_recipe(method(list_return).call[input.to_i - 1])
        end
    end

    def self.select_recipe(course_list)
        Recipe.print_list(course_list)
        puts ""
        puts "I. Type the number of the recipe you want to check out!"
        puts "II. Type 'v' if you want to see only the vegetarian options!"
        puts "III. Type 'g' if you want to see only the gluten-free options!"
        puts "IV. Type 'r' if you want to return to the menu!"
        
        input = gets.strip
        recipe = nil

        if input == "v" || input == "g"
            diet_filter = Recipe.find_by_diet(course_list, input)
            Recipe.print_list(diet_filter)
            puts "I. Type the number of the recipe you want to check out!"
            puts "II. Type the 'r' if you want to return to the menu!"
            answer = gets.strip
            if answer == "r"
                CLI.list_options
            else
                recipe = diet_filter[answer.to_i-1]
                Recipe.return_recipe(diet_filter, answer)
            end
        elsif input.count("a-z") == 0 && input.to_i <= method(course_list).call.length
            recipe = method(course_list).call[input.to_i-1]
            Recipe.return_recipe(course_list, input)
        elsif input == "r"
            CLI.list_options
        else
            puts "Please provide a valid input => (i) number from the list (ii) 'v' (iii) 'g' or (iv) 'r'"
        end

        if recipe
            puts "Did you like this recipe? Type 'save' to save it to your favorites!"
            puts "Do you want to return to the menu? Type 'r'!"
            response = gets.strip
            if response == "save"
                User.save_favorite(recipe)
                puts "It is saved!"
            elsif response == "r"
                CLI.list_options
            else
                puts "Please type valid input"
            end
        end
            
    end
    
    def self.favorites
        User.favorites
    end

    def self.meal_of_the_day
        arr = self.return_all
        i = rand(0...arr.length)
        self.format_recipe(arr[i])

        puts "Did you like this recipe? Type 'save' to save it to your favorites!"
        puts "Do you want to return to the menu? Type 'r'!"
            response = gets.strip
            if response == "save"
                User.save_favorite(arr[i])
                puts "It is saved!"
            elsif response == "r"
                CLI.list_options
            else
                puts "Please type valid input"
            end
    end

    def self.menu_of_the_day
        breakfast = self.all[:breakfast][rand(0...self.all[:breakfast].length)]
        lunch = self.all[:lunch][rand(0...self.all[:lunch].length)]
        dinner = self.all[:dinner][rand(0...self.all[:dinner].length)]

        menu = [breakfast, lunch, dinner]

        self.select_recipe(menu)
    end

end