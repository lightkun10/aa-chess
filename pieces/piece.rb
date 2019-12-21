class Piece
    attr_accessor :pos, :board, :color

    def initialize(color, board, pos)
        raise 'invalid color' unless %i(white black).include?(color)
        # raise 'invalid pos' unless board.valid_pos?(pos)
        @color, @board, @pos = color, board, pos

        board.add_piece(self, pos)
    end
end