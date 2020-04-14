#Our CLI controller
class CLI
    #controller method
    def self.call
      puts "Welcome to the Recipe Commander!"
      puts "Here you can check out our most popular simple breakfast, lunch and dinner recipes, search for vegetarian and gluten-free options or generate your meal of the day or menu of the day!"
      self.list_options
      Recipe.save_all
      self.menu
    end



    def self.list_options
        puts "1. show me all the recipes"
        puts "2. just the breakfast"
        puts "3. just the lunch"
        puts "4. just the dinner"
        puts "5. show me my favorites"
        puts "6. give me the meal of the day"
        puts "7. give me the menu of the day"
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