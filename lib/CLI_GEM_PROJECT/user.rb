class User
@@all = []
@@name = nil

 def self.save_favorite(obj)
    @@all << obj if !@@all.include?(obj)
 end

 def self.favorites
    @@all
 end

 def self.clear_favorites
    @@all.clear
 end


end