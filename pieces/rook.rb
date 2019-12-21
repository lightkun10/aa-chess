require_relative 'piece'
require_relative 'modules/slideable'

class Rook < Piece
    include Slideable

    protected

    def move_dirs
        horizontal_vertical_dirs
    end
end