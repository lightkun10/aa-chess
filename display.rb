require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :board
    
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end
end