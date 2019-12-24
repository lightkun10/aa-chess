require_relative 'cursor'
require_relative 'board'
require 'colorize'

=begin INTRODUCTION

- An instance of Cursor initializes with a cursor_pos and an instance of Board. 
- The cursor manages user input, according to which it updates its @cursor_pos. 
- The display will render the square at @cursor_pos in a different color. 
- Within display.rb require cursor.rb and set the instance variable 
    @cursor to Cursor.new([0,0], board).

=end

=begin INTRO CONT.

In cursor.rb we've provided a KEYMAP that translates keypresses 
    into actions and movements. 
The MOVES hash maps possible movement differentials. 
You can use the #get_input method as is. #read_char handles console input. 
Skim over #read_char to gain a general understanding of how the method works. 
The STDIN methods are unfamiliar to me now. NO need to fret the details.


=begin

Render the square at the @cursor_pos display in a different color. 
Test that you can move your cursor around the board by creating and 
calling a method that loops through Display#render and Cursor#get_input 
(much as Player#make_move will function later!).

=end

class Display
    attr_reader :board, :cursor
    
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end

    def build_grid
        @board.rows.map.with_index do |row, i|
            build_rows(row, i)
        end
    end

    def build_rows(row, i)
        row.map.with_index do |piece, j|
            # p piece.class() # << For testing purpose
            # assign diff colors for each piece place
            color_options = colors_for(i, j)
            # piece.to_s.colorize(color_options)
        end
    end

    def colors_for(i, j)
        if cursor.cursor_pos == [i, j] && cursor.selected
            bg = :light_green
        elsif cursor.cursor_pos == [i, j]
            bg = :light_red
        elsif (i + j).odd?
            bg = :light_blue
        else
            bg = :light_yellow
        end

        { background: bg }
    end

    def render
        # render the entire grid(collection of rows(?))
        system("clear")
        build_grid.each { |row| puts row.join }
    end
end

test_disp = Display.new(Board.new)
test_disp.render