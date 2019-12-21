require_relative 'pieces'
require 'byebug'

class Board
    attr_reader :rows

    def initialize
        # a square board divided into 64 squares (eight-by-eight)
        @sentinel = NullPiece.instance
        make_starting_grid
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @rows[row][col] = piece
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

    def empty?(pos)
        self[pos].empty?
    end

    def move_piece(start_pos, end_pos)
        # debugger
        piece = self[start_pos]
        raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        self[start_pos] = nil
        # nil
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    private

    attr_reader :sentinel

    def fill_back_row(color)
        # spread the pieces Class to the back row
        back_pieces = [
            Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
        ]

        if color == :white
            i = 7
        else
            i = 0
        end
        
        back_pieces.each_with_index do |piece_class, j|
            piece_class.new(color, self, [i, j])
        end

    end

    def fill_pawns_row(color)
        if color == :white
            i = 6
        else
            i = 1
        end

        8.times { |j| Pawn.new(color, self, [i, j]) }

        # Pawn.new(color, self, [0,0])
    end

    def make_starting_grid
        @rows = Array.new(8) { Array.new(8, sentinel) }

        [:white, :black].each do |color|
            fill_back_row(color)
            fill_pawns_row(color)
        end
    end
end
