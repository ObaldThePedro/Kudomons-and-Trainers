require_relative 'Position'

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