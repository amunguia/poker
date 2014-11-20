class GamesController < ApplicationController

  def get_cards
    @game = Game.find(get_card_params[:id])
    if (@game)
      @cards = @game.cards_for_player current_user.id
    else
      @cards = []
    end
  end

  def join_game
    if !current_user
      #not logged in
    else
      @game = Game.find(join_game_params[:id])
      if @game && @game.add_player current_user.id 
        current_user.game_id = @game.id
      else
        #could not join game: game dne or game full.
      end
    end
  end

  def move
    if current_user == nil
    	#not logged in -- redirect login
    end

    @game = Game.find(move_params[:id])
    if @game == nil
        #invalid game id -- render 404
    end
  
    if current_user.game_id != @game.id
        #user is not in game -- render 401
    end

    if @game.current_user != @current_user.id
      #not users turn -- render json, not your turn
    end

    if move_params[:action_type].eql? "fold"
       @game.current_player_folds
       if @game.one_player_left?
         winner_id = @game.get_winner  #winner bc everyone else folded
       end
    else
       if !add_bet_to_pot
         #user does not have enough
       end
    end

    if @game.table_even?
       if @game.next_card? 
         
       else
         winner_id = @game.get_winner
       end
    else
       @game.next_player
    end

    if winner_id
      #game_over
    else
      #push status
    end
  end


  private 

  def get_cards_params
    #sanitize
  end

  def join_game_params
    #sanitize
  end

  def move_params
    #sanitize
  end

  #returns true if successful, false otherwises
  def add_bet_to_pot
    if @current_user.deduct move_params[:bet_amt]
      self.pot += move_params[:bet_amt]
      @game.player_bets current_user.id, move_params[:bet_amt]
      true
    else
      false
    end
  end

end
