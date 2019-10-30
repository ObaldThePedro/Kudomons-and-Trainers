require 'pry'

require_relative 'Kudomon'
require_relative 'Position'
require_relative 'Trainer'
require_relative 'Battle'

position1 = Position.new(3.0, 2.4)
position2 = Position.new(1.5, 3.5)
position3 = Position.new(3.5,2.5)
position4 = Position.new(3.1, 2.4)
position5 = Position.new(3.4, 2.4)

world1 = World.new("Kardo")
# kudomon1 = Kudomon.new("Sourbulb", position1, world1);
kudomon2 = Kudomon.new("Mancharred", position2, world1)
# kudomon3 = Kudomon.new("Ratlr", position3, world1)
# kudomon4 = Kudomon.new("Olyphax", position4, world1)
kudomon5 = Kudomon.new("Turtlox", position5, world1)
trainer1_position = Position.new(3.4, 2.4)
trainer2_position = Position.new(1.6, 3.5)

trainer1 = Trainer.new("Ash", world1, trainer1_position);
trainer2 = Trainer.new("Kyo", world1, trainer2_position);
trainer1.catch_kudomon();
trainer2.catch_kudomon()

battle1 = Battle.new()
puts battle1.duel(trainer1,trainer2)


binding.pry
