class Piece
    attr_accessor :pos, :board, :color

    def initialize(color, board, pos)
        raise 'invalid color' unless %i(white black).include?(color)
        @color, @board, @pos = color, board, pos

        board.add_piece(self, pos)
    end

    def empty?
        false
    end

    def symbol
        # subclass implements this with unicode chess char
        raise NotImplementedError
    end
end