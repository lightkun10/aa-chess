require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
    attr_reader :board, :cursor
    
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end

    def build_grid
        @board.rows.map.with_index do |row, i|
            # visualization
            # row.each { |piece| print "#{piece.color} " }
            build_row(row, i)
        end
    end

    def build_row(row, i)
        row.map.with_index do |piece, j|
            color_options = colors_for(i, j)
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
        system ("clear")
        ## this is for the visualization. un-comment to see the visual
        # @board.rows.map! { |row| p "[][][][][][][][]" }

        # build grid from each row
        build_grid.each { |row| p row }
    end
end

new_disp = Display.new(Board.new)
new_disp.render