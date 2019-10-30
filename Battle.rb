
require_relative 'Kudomon'
require_relative 'Trainer'

POWERS = [:water, :fire, :grass, :rock, :electric, :water]
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
  
        if kudomon1.type != :psychic && kudomon2.type != :psychic
          i = 1
          loop do
            if kudomon1.type == POWERS[i] && kudomon2.type == POWERS[i - 1]
              k2_cp *= 3.5
              break
            elsif kudomon2.type == POWERS[i] && kudomon1.type == POWERS[i - 1]
              k1_cp *= 3.5
              break
            end
            i += 1
            if i == POWERS.length
              break
            end
          end
        elsif kudomon1.type == :psychic && kudomon2.type != :psychic
          k1_cp *= 3.5
        elsif kudomon2.type != :psychic && kudomon2.type == :psychic 
          k2_cp *= 3.5 
        end
        byebug
        while k1_hp > 0 && k2_hp > 0
          attack = [kudomon1,kudomon2].sample
          if attack == kudomon1
            k2_hp -= k1_cp
          elsif attack == kudomon2
            k1_hp -= k2_cp
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