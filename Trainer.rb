require_relative 'Kudomon'
require_relative 'Position'
require_relative 'World'

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
      
      if free_kudomons_in_range.length > 0
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
        duplicated_kudomon = caught_kudomon.duplicate()
        duplicated_kudomon.free = false
        duplicated_kudomon.position = self.position
        @kudomons << duplicated_kudomon
      else
        puts "There are no free pokemons in range!"
      end  
    end
  
    def kudomons
      @kudomons.flatten
    end
  
    def update_position(x, y)
      @position = Position.new(x, y)
    end
  
    def self.all
      @@all
    end
  end