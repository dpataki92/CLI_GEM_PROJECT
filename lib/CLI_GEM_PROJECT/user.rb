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


end