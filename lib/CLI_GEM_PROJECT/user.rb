class User
   @name = ""
   @favorites = []
   
   class << self
      attr_accessor :name, :favorites
   end

   def self.save_favorite(obj)
      self.favorites << obj if !self.favorites.include?(obj)
   end

   def self.clear_favorites
      self.favorites.clear
   end


   def self.access_favorites
     if User.favorites.empty?
         puts "Sorry #{User.name}, you have not saved any recipe so far!"
     else
         Recipe.select_recipe(:favorites)
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

   def self.delete_favorites
         puts ""
         Recipe.print_list(:favorites)
         puts ""
         
         puts "Type the number of the meal you want to delete"
         puts "Type 'clear' if you want to delete all your favorites"
         response = gets.strip

         if response == "clear"
            User.clear_favorites
            puts "You have no meals in the favorites!"
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


end