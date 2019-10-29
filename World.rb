require_relative 'Kudomon'
require_relative 'Trainer'


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
  