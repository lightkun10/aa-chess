require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :board
    
    def initialize(board)
        @board = board
    end
end