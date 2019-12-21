require_relative 'piece'
require_relative 'modules/slideable'

class Queen < Piece
    include Slideable

    def symbol
        '♛'
    end

    protected

    def move_dirs
        # combination of Rook and Bishop
       horizontal_vertical_dirs + diagonal_dirs
    end
end