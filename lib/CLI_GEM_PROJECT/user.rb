class User
   @name = ""
   @favorites = []
   
   # creates readers and writers for class instance variables
   class << self
      attr_accessor :name, :favorites
   end

   # saves a recipe instance to the favorites array if it is not already saved
   def self.save_favorite(obj)
      self.favorites << obj if !self.favorites.include?(obj)
   end

   # based on input, deletes recipes from favorites or clear the whole array
   def self.delete_favorites
      Recipe.print_list(User.favorites)
      puts ""
      
      puts "- Type the number of the meal you want to delete"
      puts "- Type 'clear' if you want to delete all your favorites"
      response = gets.strip

      if response == "clear"
         User.favorites.clear
         puts ""
         puts "All meals are removed from favorites!"
         sleep(2)
         puts ""
         CLI.list_options
      elsif response.count("a-zA-Z") == 0 && response.to_i <= User.favorites.length
         puts "The meal '#{User.favorites[response.to_i-1].name}' has been removed from favorites!"
         User.favorites.delete_at(response.to_i-1)
         sleep(2)
         CLI.list_options
      else
         puts ""
         puts "Please provide valid input!"
         self.delete_favorites
      end
   end

   # handles full logic for returning and deleting favorite recipes
   def self.access_favorites
     if User.favorites.empty?
         puts ""
         puts "Sorry #{User.name}, you have not saved any recipe so far!"
     else
         puts ""
         puts "Here are your favorites! Great choices, #{User.name}! :)"
         Recipe.select_recipe(User.favorites)
         puts ""
         puts "Do you want to keep your favorites?(y/n)"
         input = gets.strip
         if input == "n"
            self.delete_favorites
         elsif input == "y"
            CLI.list_options
         else
            puts ""
            puts "Please provide valid input!"
            self.access_favorites
         end
     end
     
   end

end