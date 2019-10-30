require_relative 'Position'

class Kudomon
  SPECIES = {
    "Sourbulb" => {
      type: :grass
    },
    "Mancharred" => {
      type: :fire
    },
    "Chikapu" => {
      type: :electric
    },
    "Turtlox" => {
      type: :water
    },
    "Olyphax" => {
      type: :rock
    },
    "Ratlr" => {
      type: :psychic
    }
   }
    attr_reader :species, :type, :world
    attr_accessor :position, :free, :hp, :cp
  
    @@all = []
    
    def initialize(species, position, world)
      raise "That species name is not allowed" if !SPECIES.has_key?(species)
      @species = species
      @type = SPECIES[species][:type]
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

    def duplicate
      kudomon =  Kudomon.new(self.species, self.position, self.world)
    end
  
    def self.free_kudomons
      Kudomon.all.select { |kudomon| kudomon.free == true }
    end
  end