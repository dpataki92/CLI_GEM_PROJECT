
# CLI controller
class CLI
    
    # controller method
    def self.call
      async_await = CLI::CreateAsync.new  #provides access to the asynchronous methods in the CreateAsync class
      async_await.async.save_all  #lets the scraper methods execute asynchronously while the rest of the code continues executing
      self.greeting
      async_await.await.options_and_menu  #delays the execution of the list_options and menu methods until the scraper methods finish executing
      puts ""
      puts "Thanks for using SimpleMeal!"
    end

    # includes the concurrent module and bundles up the scraper and CLI methods that have to be executed with async-await functionality
    class CreateAsync
        include Concurrent::Async
        def save_all
            Recipe.all[:breakfast] = Scraper.scrape_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/breakfast_and_brunch/")
            Recipe.all[:lunch] = Scraper.scrape_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/lunch/")
            Recipe.all[:dinner] = Scraper.scrape_recipes_from_course_page("https://www.simplyrecipes.com/recipes/course/dinner/")
        end

        def options_and_menu
            CLI.list_options
            CLI.menu
        end
    end

    # greets user, saves name and provides summary
    def self.greeting
        puts "******************************"
        puts "WELCOME TO THE SIMPLEMEAL CLI!"
        puts "******************************"
        puts ""
        puts "What's your name?"
        User.name = gets.strip
        puts ""
        puts "Hello #{User.name}! By using SimpleMeal, you can:"
        puts ""
        puts "  -check out our most popular breakfast, lunch and dinner recipes"
        puts "  -search for vegetarian and gluten-free options"
        puts "  -ask us to recommend you a meal or even a full menu for the day"
        puts "  -save your favorite recipes and get back to them later"
        puts ""
        puts "Press 'y' when you are ready!"
        input = gets.strip.downcase
        if input == 'y'
            puts ""
            puts "Cool! We are getting you the most popular recipes on #{Time.new.strftime("%d of %B, %Y")}"
            puts ""
            puts "It may take a few seconds...."
            puts ""
        else
            puts ""
            puts "Hmmm, it seems you did not type 'y'. If you are not in the mood, just type 'exit' after the menu is loaded!"
            puts ""
        end
    end


    # prints menu
    def self.list_options
        puts "1. All recipes"
        puts "2. Breakfast recipes"
        puts "3. Lunch recipes"
        puts "4. Dinner recipes"
        puts "5. Favorites"
        puts "6. Meal of the day"
        puts "7. Menu of the day"
    end
 
    # handles logic for different menu options
    def self.menu
        input = nil
        while input != "exit"
            puts ""
            puts "Enter a number from the menu or type exit!"
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
            User.access_favorites
            when "6"
            Recipe.meal_of_the_day
            when "7"
            Recipe.menu_of_the_day
            else
            puts ""
            puts "Please provide valid input!"
            puts ""
            end
        end
    end

end 