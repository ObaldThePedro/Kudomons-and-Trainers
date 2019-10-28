require 'pry'

class Kudomon
  attr_reader :species, :type, :world
  attr_accessor :position, :free

  @@all = []
  
  def initialize(species, type, position, world)
    @species = species
    @type = type
    @position = position
    @world = world
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
    
    position = nil
    closest = Math.sqrt((self.position.x - free_kudomons_in_range[0].position.x)**2 + (self.position.y - free_kudomons_in_range[0].position.y)**2)
    free_kudomons_in_range.each_with_index do |kudomon, index|
      if closest > Math.sqrt((self.position.x - free_kudomons_in_range[index].position.x)**2 + (self.position.y - free_kudomons_in_range[index].position.y)**2)
        closest = Math.sqrt((self.position.x - kudomon.position.x)**2 + (self.position.y - kudomon.position.y)**2)
        position = index
      end
    end
    puts closest
    puts position
    caught_kudomon = free_kudomons_in_range[position]
    caught_kudomon.free = false
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


class Position
  attr_reader :x, :y
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


  def name
    @name
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
position4 = Position.new(3.5, 2.4)
position5 = Position.new(1.3, 2.4)

world1 = World.new("Kardo")
kudomon1 = Kudomon.new("Sourbulb", "grass", position1, world1);
kudomon2 = Kudomon.new("Bulby","electric", position2, world1)
kudomon3 = Kudomon.new("Ratlr","psychic", position3, world1)
kudomon4 = Kudomon.new("Olyphax","rock", position4, world1)
kudomon5 = Kudomon.new("Turtlox","water", position5, world1)

trainer_position = Position.new(3.4, 2.4)
trainer1 = Trainer.new("Ash", world1, trainer_position );

binding.pry
