require_relative 'pieces'
require 'byebug'

class Board
    attr_reader :rows

    def initialize
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

=begin

write a #checkmate?(color) method. 
    - If the player is in check, and 
    - if none of the player's pieces have any #valid_moves (to be implemented in a moment), 
    => then the player is in checkmate
=end
    def checkmate?(color)
    end

    def empty?(pos)
        self[pos].empty?
    end

    def in_check(color)
        ## returns whether a player is in check. You can implement this by 
        #   (1) finding the position of the King on the board, then 
        #   (2) seeing if ANY of the opposing pieces can move to that position.
        king_pos = find_king(color)
        pieces.any? do |piece|
            piece.moves.include?(king_pos) && piece.color != color
        end
    end

    def move_piece(start_pos, end_pos)
        # debugger
        piece = self[start_pos]
        raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        self[start_pos] = nil
    end

    def pieces
        # debugger
        @rows.flatten.reject { |piece| piece.empty? }
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

    def find_king(color)
        king_pos = pieces.find { |piece| piece.is_a?(King) && piece.color == color }
        return king_pos || (raise "Where's the King?")
    end

    def make_starting_grid
        @rows = Array.new(8) { Array.new(8, sentinel) }

        [:white, :black].each do |color|
            fill_back_row(color)
            fill_pawns_row(color)
        end
    end
end

new_b = Board.new
new_b.in_check(:black)