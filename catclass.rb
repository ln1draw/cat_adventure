  $winner = false
  $can_escape = false



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
      @location.name
    end

    def travelhist
      @travelhist
    end

    def move(location)
      @location = location
      if @travelhist[location].nil?
        @travelhist[location] = 1
      else
        @travelhist[location] = @travelhist[location]+1
      end
    end

  end

  class Starbuck < Animal
    def initialize
      @hp = 10
      @name = "STARBUCK"
      @location = $master
      @description = File.readlines("starbuck.txt")
      @travelhist = {@location => 1}
    end



    def escape
      if $can_escape #this should run checkroom eventually
        move
      else
        puts "You can't ESCAPE! There's something in your way!"
      end
    end

    def nap
      if $can_escape #This should run checkroom eventually
        if @location == $guest
          puts File.readlines("wintext.txt")
          $winner = true #This part doesn't exist yet
        else
          puts "You can't nap here! This isn't the right place for that."
        end
      else
        puts "You can't nap here! It isn't safe!"
      end
    end

    def look(at)
      puts at.description
    end

    def hiss(at)
      puts "You hiss at #{at.name}"
      if @hp < at.hp
        heal(1)
      elsif hp > at.hp
        takes_damage(1)
      end
    end

    def attack(at)
      case at
      when $hooman1 then
        puts "Attacking the TALL HOOMAN upsets you. You retreat"
        puts "to the MASTER BEDROOM with some emotional damage."
        $hooman1.takes_damage(2)
        $hooman1.location.exit($hooman1)
        takes_damage(1)
        @location = $master
        travel_hist[$master] = travel_hist[$master] + 1
        $helo.heal(2)
        $apollo.heal(2)

      when $hooman2 then
        puts "Attacking the SHORT HOOMAN upsets you. You retreat"
        puts "to the MASTER BEDROOM with some emotional damage."      
        $hooman2.takes_damage(3)
        $hooman2.location.exit($hooman2)
        takes_damage(1)
        @location = $master
        travel_hist[$master] = travel_hist[$master] + 1
        $helo.heal(2)
        $apollo.heal(2)

      when $apollo then
        puts "Uh-oh. You swipe a paw at APOLLO, and he nips back!"
        $apollo.takes_damage(2)
        takes_damage(3)

      when $helo then
        puts "You startled HELO! He pawes back at you a little, and it hurts."
        $helo.takes_damage(2)
        takes_damage(3)

      when $athena then
        puts "You attacked ATHENA. WHY would you attack ATHENA?!?!"
        $athena.takes_damage(7)

      when $starbuck then
        puts "You're trying to eat your own tail! It's super adorable, but not super effective."
        $starbuck.takes_damage(1)
        $hooman1.heal(1)
        $hooman2.heal(1)
      else
        puts "You can't attack that! Just focus on trying to ESCAPE!"
      end
    end

    def talk(at)
      case at
      when $hooman1 then
        if $hooman1.hp >= 3
          puts "TALL HOOMAN thinks you're adorable!"
          $hooman1.takes_damage(2)
        else
          puts "TALL HOOMAN is tired of your sass."
          $hooman1.location.exit($hooman1)
        end

      when $hooman2 then
        if $hooman2.hp >= 2
          puts "SHORT HOOMAN just can't get enough of you!"
          $hooman2.takes_damage(1)
        else
          puts "SHORT HOOMAN has had enough of your puffery!"
          $hooman2.location.exit($hooman2)
        end

      when $apollo then
        puts "APOLLO barks back!"
        $apollo.takes_damage(1)
        $apollo.location.exit($apollo)

      when $helo then
        puts "HELO just wanted to be friends :("
        $helo.location.exit($helo)

      when $athena then
        puts "ATHENA will help you any way she can!"

        if @current_location == $apollo.current_location
          puts "ATHENA distracted APOLLO for you! He chased her to the other room!"
          $athena.takes_damage(1)
          $athena.location.exit($athena)
          $apollo.location.exit($apollo)

        elsif @current_location == $helo.current_location
          puts "ATHENA walks up to HELO and boops him on the nose. Her"
          puts "cuddly adorableness reminds him of how much he loves naps."
          $helo.takes_damage(10)
          $athena.takes_damage(6)

        elsif @current_location == $hooman1.current_location
          puts "ATHENA jumps on the TALL HOOMAN's shoulders and"
          puts "runs around! TALL HOOMAN is happy AND distracted."
          puts "She wanders off to the other room, taking ATHENA with her!"
          $hooman1.location.exit($hooman1)
          $athena.location.exit($athena)

        elsif @current_location == $hooman2.current_location
          puts "ATHENA meows at SHORT HOOMAN until he says \"OH NO!"
          puts "Hungry kittens! They'll be more ravenous than raptors!\""
          puts "and he runs off to the other room."
          $hooman2.location.exit($hooman2)

        else
          puts "ATHENA loves you the most!"
          $athena.heal(1)
          heal(1)
        end
      else
        puts "Meowing at yourself is adorable, but it isn't helping you ESCAPE!"
        takes_damage(1)
      end
    end
  end

  class Room
    attr_reader :name, :description, :exits

    def initialize(roomhash)
      @name = roomhash[:name]
      @description = roomhash[:description]
      @exits = roomhash[:exits] #this value should be an array
    end
    

    def exit(animal)
      if @exits.length == 1
        animal.move(exits[0])
      else
        new_hash = {}
        animal.travelhist.each do |key, value|
          @exits.each do |exit|
            if key == exit
              new_hash[key] = value
            end
          end
        end
        animal.move(new_hash.invert.sort.flatten[1])
      end
    end
  end



  #THIS
  #PART
  #DOESN'T
  #WORK
  def checkroom
    if sb.current_location == $helo.current_location || sb.current_location == $apollo.current_location || sb.current_location == $hooman1.current_location || sb.current_location == $hooman2.current_location
      $can_escape = false
    else
      $can_escape = true
    end
  end

  $master = Room.new({:name => "MASTER BEDROOM", :description => "A master bedroom", :exits => [$kitchen]})
  $kitchen = Room.new({:name => "KITCHEN", :description => "The kitchen", :exits => [$master, $guest]})
  $guest = Room.new({:name => "GUEST", :description => "A guest bedroom", :exits => [$kitchen]})
  $athena = Animal.new({:name => "ATHENA", :location => $master, :description => File.readlines("athena.txt")})
  $helo = Animal.new({:name => "HELO", :location => $master, :description => File.readlines("helo.txt")})
  $apollo = Animal.new({:name => "APOLLO", :location => $master, :description => File.readlines("apollo.txt")})
  $hooman1 = Animal.new({:name => "TALL HOOMAN", :location => $kitchen, :description => "It's a hooman. They all look the same to you."})
  $hooman2 = Animal.new({:name => "SHORT HOOMAN", :location => $guest, :description => "It's a hooman. They all look the same to you."})
  sb = Starbuck.new  

  def get_input
  end