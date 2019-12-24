class Piece
    attr_accessor :pos, :board, :color

    def initialize(color, board, pos)
        raise 'invalid color' unless %i(white black).include?(color)
        raise 'invalid pos' unless board.valid_pos?(pos)

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
    
    def valid_moves
        moves.reject { |end_pos| move_into_check?(end_pos) }
    end
    

    private

    def move_into_check?(end_pos)
        dup_board = board.dup
        dup_board.move_piece!(pos, end_pos)
        dup_board.in_check?(color)
    end
end

=begin Phase V: Piece#valid_moves

You will want a method on Piece that filters out the moves of a Piece 
that would leave the player in check. 

A good approach is to write a Piece#move_into_check?(end_pos) method that will:
- Duplicate the Board and perform the move
- Look to see if the player is in check after the move (Board#in_check?)



To do this, you'll have to write a Board#dup method. 
Your #dup method should duplicate not only the Board, but the pieces on the Board. 

Be aware: Ruby's #dup method does not call dup on the instance variables, 
so you may need to write your own Board#dup method that will 
dup the individual pieces as well.

=end