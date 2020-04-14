#Our CLI controller
class CLI
    #controller method
    def self.call
      async_await = Recipe::CreateAsync.new
      async_await.async.save_all
      self.greeting
      async_await.await.options_and_menu
      puts "Thanks for using SimpleMeal!"
    end

    def self.greeting
        puts "******************************"
        puts "WELCOME TO THE SIMPLEMEAL CLI!"
        puts "******************************"
        puts ""

        puts "What's your name?"
        name = gets.strip
        puts ""
        puts "Hello #{name}! By using SimpleMeal, you can:"
        puts "  -check out our most popular breakfast, lunch and dinner recipes"
        puts "  -search for vegetarian and gluten-free options"
        puts "  -ask us to recommend you a meal or even a full menu for the day"
        puts "  -save your favorite recipes and get back to them later once you have finished searching"
        puts ""
        puts "Press 'y' if you are ready!"
        input = gets.strip.downcase
        if input == 'y'
            puts ""
            puts "Cool! We are getting you the most popular recipes on #{Time.new.strftime("%d of %B, %Y")}"
            puts ""
            puts "It may take a few seconds...."
            puts ""
        else
            puts ""
            puts "Maybe next time! Now just type 'exit'!"
            puts ""
        end
    end



    def self.list_options
        puts "1. All recipes"
        puts "2. Breakfast recipes"
        puts "3. Lunch recipes"
        puts "4. Dinner recipes"
        puts "5. Favorites"
        puts "6. Meal of the day"
        puts "7. Menu of the day"
    end
 
    def self.menu
        input = nil
        while input != "exit"
            puts "Enter a number or type exit"
            input = gets.strip.downcase
            case input
            when "1"
            Recipe.select_recipe(:return_all)
            when "2"
            Recipe.select_recipe(:all_breakfast)
            when "3"
            Recipe.select_recipe(:all_lunch)
            when "4"
            Recipe.select_recipe(:all_dinner)
            when "5"
                if User.favorites.empty?
                    puts "You have not saved any recipe so far!"
                else
                    Recipe.select_recipe(:favorites)
                end
            when "6"
                Recipe.meal_of_the_day
            when "7"
                Recipe.menu_of_the_day
            end
        end
    end




end 