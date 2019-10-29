require 'pry'

class Kudomon
  attr_reader :species, :type, :world
  attr_accessor :position, :free, :hp, :cp

  @@all = []
  
  def initialize(species, type, position, world)
    @species = species
    @type = type
    @position = position
    @world = world
    @hp = 100;
    @cp = 10;
    @free = true
    @@all << self
  end

  def update_position(x, y)
    @position = Position.new(x, y)
  end
  
  def self.all
    @@all
  end

  def self.free_kudomons
    Kudomon.all.select { |kudomon| kudomon.free == true }
  end
end


class Trainer
  attr_reader :name, :world, :kudomons
  attr_accessor :position

  @@all = []
  def initialize(name, world, position)
    @kudomons = []
    @name = name
    @world = world
    @position = position
    @@all << self
  end

  def catch_kudomon
    free_kudomons_in_range = Kudomon.free_kudomons.select {|kudomon| kudomon.world == self.world && (kudomon.position.x >= self.position.x - 2 && kudomon.position.x <= self.position.x + 2) && (kudomon.position.y >= self.position.y - 2 || kudomon.position.y <= self.position.y + 2)}
    
    pos = nil
    closest = Math.sqrt((self.position.x - free_kudomons_in_range[0].position.x)**2 + (self.position.y - free_kudomons_in_range[0].position.y)**2)
    free_kudomons_in_range.each_with_index do |kudomon, index|
      if closest > Math.sqrt((self.position.x - free_kudomons_in_range[index].position.x)**2 + (self.position.y - free_kudomons_in_range[index].position.y)**2)
        closest = Math.sqrt((self.position.x - kudomon.position.x)**2 + (self.position.y - kudomon.position.y)**2)
        pos = index
      end
    end
    if pos != nil
      caught_kudomon = free_kudomons_in_range[pos]
    else
      caught_kudomon = free_kudomons_in_range[0]
    end
    
    caught_kudomon.free = false
    caught_kudomon.position = self.position
    puts caught_kudomon.position.x
    @kudomons << caught_kudomon
  end

  def kudomons
    @kudomons.flatten
  end

  def add_position(x, y)
    @position = Position.new(x, y)
  end

  def self.all
    @@all
  end
end

class Battle
  
  def duel(trainer1, trainer2)
    if trainer1.kudomons.length == 0 || trainer2.kudomons.length == 0
      puts "A trainer does not have kudomons to fight! Try and capture some kudomons before attempting to go on a duel!"
    else
      kudomon1 = trainer1.kudomons.sample
      kudomon2 = trainer2.kudomons.sample
      k1_hp = kudomon1.hp
      k2_hp = kudomon2.hp
      k1_cp = kudomon1.cp
      k2_cp = kudomon2.cp

      
      
      while k1_hp > 0 && k2_hp > 0
        byebug
        attack = [kudomon1,kudomon2].sample
        if attack == kudomon1
          k2_hp -= k2_cp
        elsif attack == kudomon2
          k1_hp -= k1_cp
        end

        if k1_hp <= 0
          return kudomon2.species
        elsif k2_hp <= 0
          return kudomon1.species
        end
      end
    end
  end
end

class Position
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end


class World
  attr_reader :name
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
  end

  def add_Trainer(trainer)
    trainer = Trainer.new(name)
  end

  def trainers
    Trainer.all.select {|trainer| trainer.world == self}
  end

  def kudomons
    Kudomon.all.select {|kudomon| kudomon.world == self}
  end

  def self.all
    @@all
  end
end

position1 = Position.new(3.0, 2.4)
position2 = Position.new(5.2, 2.4)
position3 = Position.new(3.5,2.5)
position4 = Position.new(3.1, 2.4)
position5 = Position.new(1.2, 2.4)

world1 = World.new("Kardo")
kudomon1 = Kudomon.new("Sourbulb", "grass", position1, world1);
kudomon2 = Kudomon.new("Bulby","electric", position2, world1)
kudomon3 = Kudomon.new("Ratlr","psychic", position3, world1)
kudomon4 = Kudomon.new("Olyphax","rock", position4, world1)
kudomon5 = Kudomon.new("Turtlox","water", position5, world1)

trainer1_position = Position.new(3.4, 2.4)
trainer2_position = Position.new(1.6, 3.5)

trainer1 = Trainer.new("Ash", world1, trainer1_position);
trainer2 = Trainer.new("Kyo", world1, trainer2_position);
trainer1.catch_kudomon();
trainer2.catch_kudomon()

battle1 = Battle.new()
puts battle1.duel(trainer1,trainer2)


binding.pry
