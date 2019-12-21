require_relative 'piece'
require_relative 'modules/stepable'

class King < Piece
    def symbol
        '♚'
    end

    protected

    def move_diffs
        [
            [-1, -1],
            [-1, 0], 
            [-1, 1],
            [0, -1],
            [0, 1],
            [1, -1],
            [1, 0],
            [1, 1]
        ]
    end
end