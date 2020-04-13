#Our CLI controller
class Recipes
    #controller method
    def call
      puts "Welcome to the Recipe Commander!"
      puts "Here you can check out our most popular simple breakfast, lunch and dinner recipes, search for vegetarian and gluten-free options or generate your meal of the day or menu of the day!"
      list_options
      Recipe.save_all
      menu
    end



    def list_options
        puts "1. show me all the recipes"
        puts "2. just the breakfast"
        puts "3. just the lunch"
        puts "4. just the dinner"
    end
 
    def menu
        input = nil
        while input != "exit"
            puts "Enter a number or type exit"
            input = gets.strip.downcase
            case input
            when "1"
            Recipe.print_list(:return_all)
            diet_filter = Recipe.find_by_diet(:return_all)
            Recipe.print_list(diet_filter)
            Recipe.return_recipe(diet_filter)
            when "2"
            Recipe.print_list(:all_breakfast)
            Recipe.find_by_diet(:all_breakfast)
            when "3"
            Recipe.print_list(:all_lunch)
            Recipe.find_by_diet(:all_lunch)
            when "4"
            Recipe.print_list(:all_dinner)
            Recipe.find_by_diet(:all_lunch)
            when "menu"
            list_options
            end
        end
    end


end 