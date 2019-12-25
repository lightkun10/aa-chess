require_relative 'display'
require_relative 'player'

class HumanPlayer < Player

=begin

You should write a HumanPlayer class with one method (#make_move).
This method should call Cursor#get_input and appropriately handle the different responses 
(a cursor position or nil). 

In that case, Game#play method just continuously calls #make_move.

=end

    def make_move(_board)
        start_pos, end_pos = nil, nil

        until start_pos && end_pos
            display.render
            
            if start_pos
                puts "#{color}'s turn. Move to where?"
                end_pos = display.cursor.get_input
            else
                puts "#{color}'s turn. Move from where?"
                start_pos = display.cursor.get_input
            end
        end
        
        [start_pos, end_pos]
    end


end