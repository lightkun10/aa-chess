require_relative 'cursor'
require_relative 'board'
require 'colorize'

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