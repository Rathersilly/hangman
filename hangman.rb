require './game_class.rb'
require 'yaml'

class GameController

  def initialize
    start_game

  end

  def start_game
    
    game = Game.new(:new)
    while game.win_status == :load
        filename = game.load_file
        filename = "saves/" + filename
        game = YAML::load(File.open(filename))
        game.play_game
    end
      

  end
  



end

GameController.new

