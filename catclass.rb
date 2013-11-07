class Animal
  attr_accessor :location, :travelhist
  attr_reader :hp, :name, :description

  def initialize(infohash)
    @hp = 10
    @name = infohash[:name]
    @location = infohash[:location]
    @travelhist = {@location => 1}
    @description = infohash[:description]
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

athena = Animal.new({:name => "ATHENA", :location => "MASTER BEDROOM", :description => File.readlines("athena.txt")})
helo = Animal.new({:name => "HELO", :location => "MASTER BEDROOM", :description => File.readlines("helo.txt")})
apollo = Animal.new({:name => "APOLLO", :location => "MASTER BEDROOM", :description => File.readlines("apollo.txt")})
hooman1 = Animal.new({:name => "TALL HOOMAN", :location => "KITCHEN", :description => "It's a hooman. They all look the same to you."})
hooman2 = Animal.new({:name => "SHORT HOOMAN", :location => "GUEST BEDROOM", :description => "It's a hooman. They all look the same to you."})


class Starbuck < Animal
  def initialize
    @hp = 10
    @name = "STARBUCK"
    @location = "MASTER BEDROOM"
    @description = File.readlines("starbuck.txt")
    @travelhist = {@location => 1}
  end

  def checkroom
    #checks to see if there are any other animals in the room
  end

  def escape
    can_escape = true
  end

  def nap
  end

  def look(at)
  end

  def hiss(at)
  end

  def attack(at)
  end

  def talk(at)
  end 

  def get_input
  end

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





