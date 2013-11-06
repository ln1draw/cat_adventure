class Animal
  attr_accessor :location, :travelhist
  attr_reader :hp, :name, :description

  def initialize(hp, name, location, description)
    @hp = hp
    @name = name
    @location = location
    @travelhist = {location => 1}
    @description = description
  end

  def takes_damage(ouch)
    @hp = @hp - ouch
    puts "Ouch! #{@name} took #{ouch} points of damage!"
  end

  def heal(yay)
    @hp = @hp - yay
    puts "Yay! #{@name} healed for #{yay}!"
  end

  def current_location
    @location
  end

  def travelhist
    @travelhist
  end

  def move(location)
    @location = location
    @travelhist[location] = @travelhist[location]+1
  end

end

sb = Animal.new(10, "STARBUCK", "MASTER BEDROOM", "You are a cat! You're a tiny black cat with long whiskers \n and a propensity for mischief. Everyone is drawn to your adorableness, \n but your agility and quick-wittedness will help you ESCAPE!")

class Room
  attr_reader :name, :description, :exits

  def initialize(name, description, exits)
    @name = name
    @description = description
    @exits = exits
  end

  def exit(animal)
    if @exit.length == 0
      animal.move(exit[0])
    else
      new_hash = {}
      animal.travelhist.each do |key, value|
        exit.each do |exits|
          if key == exits
            new_hash[key] = value
          end
        end
      end
      # still needs to sort the stupid thing and then do something with that!


      #search through the travel_hist hash for the keys that match
      #the strings in exit. then, from those, find the value that is the lowest
      #and call animal.move on that location
    end
  end

end





