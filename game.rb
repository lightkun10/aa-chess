require_relative 'board'
require_relative 'display'

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
    end
end