module Stepable
    def moves
        move_diffs.each_with_object([]) do |(dx, dy), moves|
            cur_x, cur_y = pos
            pos = [dx + cur_x, dy + cur_y]

            next unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves.push(pos)
            elsif board[pos].color != color
                moves.push(pos)
            end
        end
    end

    private

    def move_diffs
        # subclass implement this
        raise NotImplementedError
    end
end