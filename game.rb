require_relative 'board'
require_relative 'humanplayer'

# Game class that constructs a Board object
class Game
attr_reader :board, :display, :players, :current_player

    def initialize
        @board = Board.new # board object
        @display = Display.new(@board)
        @players = {
            black: HumanPlayer.new(:black, @display),
            white: HumanPlayer.new(:white, @display)
        }
        @current_player = :white
    end

    def play
        until board.checkmate?(current_player)
            start_pos, end_pos = @players[current_player].make_move(board)
            board.move_piece(current_player, start_pos, end_pos)
            
            swap_turn!
            # notify_players ## << DO NOT DELETE, still in progress
        end

        display.render
        puts "#{current_player} is checkmatted"
    end

    private

    def notify_players
    end

    def swap_turn!
        if current_player == :white
            @current_player = :black
        else
            @current_player = :white
        end
    end

end

if $PROGRAM_NAME == __FILE__
    Game.new.play
end 