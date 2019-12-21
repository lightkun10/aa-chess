module Stepable
    def moves
        move_diffs.each_with_object([]) do |(dx, dy), moves|
            cur_x, cur_y = pos
            pos = [dx + cur_x, dy + cur_y]

            moves.push(pos) if board.empty?(pos)
        end
    end

    private

    def move_diffs
        # subclass implement this
        raise NotImplementedError
    end
end