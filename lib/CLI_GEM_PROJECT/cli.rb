#Our CLI controller
class Recipes
    #controller method
    def call
      Recipe.save_all
      puts "Welcome to the Recipe Commander!"
      list_options
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
            Recipe.find_by_diet(:return_all)
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