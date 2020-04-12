#Our CLI controller
class Recipes
    #controller method
    def call
      puts "Welcome to the Recipe Commander!"
      list_recipes
      menu
    end



    def list_recipes
        puts "1. print all recipe diet categories"
        puts "2. show all recipe objects"
        puts "3. print a random recipe"
    end
 
    def menu
        input = nil
        while input != "exit"
            puts "Enter a number or type exit"
            input = gets.strip.downcase
            case input
            when "1"
            Recipe.create_multiple_recipes("https://www.simplyrecipes.com/recipes/course/dinner/").each {|recipe| p recipe.diet}
            when "2"
            puts Recipe.create_multiple_recipes("https://www.simplyrecipes.com/recipes/course/dinner/")
            when "3"
            random = rand(0..17)
            p Recipe.create_multiple_recipes("https://www.simplyrecipes.com/recipes/course/dinner/")[random]
            when "return"
            list_recipes
            end
        end
    end


end 