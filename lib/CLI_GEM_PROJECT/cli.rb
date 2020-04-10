#Our CLI controller
class Recipes
    #controller method
    def call
      puts "Welcome to the Recipe Commander!"
      list_recipes
      menu
      goodbye
      Recipe.create_recipe("https://www.allrecipes.com/recipe/264444/grilled-mediterranean-salmon-in-foil/?internalSource=staff%20pick&referringId=16704&referringContentType=Recipe%20Hub")
    end



    def list_recipes
        puts "1. vegan recipe"
        puts "2. vegetarian recipe"
        puts "3. mediterran recipe"
    end
 
    def menu
        input = nil
        while input != "exit"
            puts "Enter the number of the recipe you'd like to discover, type list if you want to return to the list or type exit"
            input = gets.strip.downcase
            case input
            when "1"
            puts "more info on 1.."
            when "2"
            puts "more info on 2.."
            when "3"
            puts "more info on 3.."
            when "list"
            list_recipes
            end
        end
    end

    def goodbye
        puts "See ya"
    end
end 