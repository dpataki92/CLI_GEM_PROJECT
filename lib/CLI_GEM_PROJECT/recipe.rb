class Recipe

    attr_accessor :name, :diet, :cook_time, :ingredients, :directions, :url

    @@all = {
        breakfast: nil,
        lunch: nil,
        dinner: nil
    }
    
    class CreateAsync
        include Concurrent::Async
        def save_all
            Recipe.all[:breakfast] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/breakfast_and_brunch/")
            Recipe.all[:lunch] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/lunch/")
            Recipe.all[:dinner] = Scraper.create_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/dinner/")
        end

        def options_and_menu
            CLI.list_options
            CLI.menu
        end
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
        if list_return.instance_of? Array
            if input == "v"
                list_return.select {|dish| dish.diet.include?("vegetarian")}
            elsif input == "g"
                list_return.select {|dish| dish.diet.include?("gluten-free")}
            end
        else
            if input == "v"
                method(list_return).call.select {|dish| dish.diet.include?("vegetarian")}
            elsif input == "g"
                method(list_return).call.select {|dish| dish.diet.include?("gluten-free")}
            end
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
        course_list = method(course_list).call if !course_list.instance_of? Array
        self.print_list(course_list)
        self.filter_or_return(course_list)
    end
    
    def self.filter_or_return(course_list)
        puts ""
        puts "I. Type the number of the recipe you want to check out!"
        puts "II. Type 'v' if you want to see only the vegetarian options!"
        puts "III. Type 'g' if you want to see only the gluten-free options!"
        puts "IV. Type 'm' if you want to return to the menu!"
        
        input = gets.strip
        recipe = nil

        if input == "v" || input == "g"
            diet_filter = Recipe.find_by_diet(course_list, input)
            if diet_filter.empty?
                puts ""
                puts "Sorry, this list does not contain any meals from the selected category :("
                sleep(2)
                self.filter_or_return(course_list)
            else
                Recipe.print_list(diet_filter)
            end

            puts ""
            puts "I. Type the number of the recipe you want to check out!"
            puts "II. Type the 'm' if you want to return to the menu!"
            answer = gets.strip
            if answer == "m"
                CLI.list_options
            else
                recipe = diet_filter[answer.to_i-1]
                Recipe.return_recipe(diet_filter, answer)
            end
        elsif input.count("a-z") == 0 && input.to_i <= course_list.length
            recipe = course_list[input.to_i-1] 
            Recipe.return_recipe(course_list, input)
        elsif input == "m"
            CLI.list_options
        else
            puts ""
            puts "Please provide a valid input!"
            sleep(2)
            self.select_recipe(course_list)
        end

        if recipe
            self.save_or_return(recipe, course_list)
        end
    end

    def self.favorites
        User.favorites
    end

    def self.save_or_return(recipe, list)
        puts "Did you like this recipe? Type 'save' to save it to your favorites!"
        puts "Do you want to return to the list? Type 'r'!"
        puts "Do you want to go back to the menu? Type 'm'!"
        response = gets.strip
        if response == "save"
            User.save_favorite(recipe)
            puts "It is saved!"
            puts ""
            sleep(2)
            self.select_recipe(list)
        elsif response == "r"
            self.select_recipe(list)
        elsif response == "m"
            CLI.list_options
        else
            puts ""
            puts "Please type valid input!"
            sleep(2)
            self.select_recipe(list)
        end
    end

    def self.meal_of_the_day
        arr = self.return_all
        i = rand(0...arr.length)
        self.format_recipe(arr[i])
        self.save_or_return(arr[i], arr)
    end

    def self.menu_of_the_day
        breakfast = self.all[:breakfast][rand(0...self.all[:breakfast].length)]
        lunch = self.all[:lunch][rand(0...self.all[:lunch].length)]
        dinner = self.all[:dinner][rand(0...self.all[:dinner].length)]

        menu = [breakfast, lunch, dinner]

        self.select_recipe(menu)
    end



end