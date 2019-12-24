require_relative 'pieces'
require 'byebug'

class Board
    attr_reader :rows

    def initialize(fill_board = true)
        @sentinel = NullPiece.instance
        make_starting_grid(fill_board)
        #PS: Check Board#dup to know why fill_board is made
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
        # return false unless in_check?(color)
        # select the same piece

        # If the player is in check, and 
        # if none of the player's pieces have any #valid_moves (to be implemented in a moment), 
        # then the player is in checkmate.
        return false unless in_check?(color)

        pieces_same_color = pieces.select { |piece| piece.color == color }
        pieces_same_color.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def dup
        # duplicate not only the board, but also each individual pieces
        clone_board = Board.new(false)
        # with this, I am not filling the board with new grid
        # yet still clone it
        
        # duplicate each pieces
        pieces.each do |piece|
            # p piece.class.new(piece.color, self, ) XXXXXXX WRONG
            ## Not self, we are making a CLONE here, reference the cloned board instead
            piece.class.new(piece.color, clone_board, piece.pos)
        end

        clone_board
    end

    def empty?(pos)
        self[pos].empty?
    end

    def in_check?(color)
        king_pos = find_king(color)
        pieces.any? do |piece|
            piece.moves.include?(king_pos) && piece.color != color
        end
    end

    def move_piece(turn_color, start_pos, end_pos)
        raise "Start position is empty" if empty?(start_pos)

        start_piece = self[start_pos]

        if start_piece.color != turn_color
            raise "Please move your own piece."
        elsif !start_piece.moves.include?(end_pos)
            raise "You can't move that piece like that..."
        elsif !start_piece.valid_moves.include?(end_pos)
            raise "You can't move into check..."
        end

        move_piece!(start_pos, end_pos)
    end

    # move piece without check
    def move_piece!(start_pos, end_pos) # [0, 1], [3, 1]
        start_piece = self[start_pos]

        # p self[start_pos].class #<< before moved
        self[end_pos] = start_piece
        self[start_pos] = sentinel
        # p start_piece.pos # << pos before
        start_piece.pos = end_pos

        nil
    end

    # gather all pieces in one place
    def pieces
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
        king_pos || (raise "Where's the King?")
    end

    def make_starting_grid(fill_board)
        @rows = Array.new(8) { Array.new(8, sentinel) }
        return unless fill_board == true

        [:white, :black].each do |color|
            fill_back_row(color)
            fill_pawns_row(color)
        end
    end
end

new_b = Board.new

###### VISUALIZATION ######
# Use for checking/debugging
# Please don't delete this

new_b.rows.each do |row|
    row.each do |piece|
            p "#{piece.pos} ---- #{piece.class}"
    end
end
###### VISUALIZATION ######