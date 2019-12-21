module Slideable
    HORIZONTAL_VERTICAL_DIRS = [ # [5, 4]
        [-1, 0],
        [1,  0],
        [0, -1],
        [0,  1]   
    ].freeze

    DIAGONAL_DIRS = [
        [-1, -1],
        [-1, 1],
        [1, -1],
        [1, 1]
        
    ].freeze

    def horizontal_vertical_dirs
        HORIZONTAL_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []

        move_dirs.each do |(dx, dy)|
            moves += grow_unblocked_moves_in_dir(dx, dy)
        end
    end

    def move_dirs
        # subclass implement this
        raise NotImplementedError
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        cur_x, cur_y = pos
        moves = []

        loop do
            cur_x, cur_y = dx + cur_x, dy + cur_y

            pos = [cur_x, cur_y]

            break unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves.push(pos)
            else
                # can take an opponent's piece
                moves.push(pos) if board[pos].color != color
            end

        end
        moves
    end
end