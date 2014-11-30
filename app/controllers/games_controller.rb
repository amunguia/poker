class GamesController < ApplicationController

  def get_cards
    @game = Game.find(params[:id].to_i)
    if (@game)
      @cards = @game.cards_for_player current_user.id
    else
      @cards = []
    end
    render :json => { :cards => @cards}
  end

  def join_game
    if !current_user
      render :json => {:message => "Not logged in.", :result => false}
    else
      #Check user has min balance
      @game = Game.find(params[:id].to_i)
      if @game
        player = @game.add_player current_user.id
        if player
          render :json => {:message => "Joined game.", :result => true, :player => player}
        else
          render :json => {:message => "Could not join game", :result => false}
        end
      else
        #could not join game: game dne or game full.
        render  :json => {:message => "Could not join game", :result => false}
      end
    end
  end

  def move
    if current_user == nil
    	render :json => {:message => "You are not logged in.", :result => false}
      return
    end

    @game = Game.find(params[:id])
    if @game == nil
      render :json => {:message => "That is an invalid game id.", :result => false}
      return
    end
  
    if !@game.valid_player current_user
        render :json => {:message => "Sorry, you are not participating in this game", :result => false}
        return
    end

    if !@game.is_full?
      render :json => {:message => "Sorry, this game has not yet started", :result => false}
      return
    end

    if @game.is_not_turn current_user
      render :json => {:message => "Sorry. It is not your turn.", :result => false}
      return
    end

    if params[:action_type].eql? "fold"
       @game.current_player_folds
       if @game.one_player_left?
         winner_id = @game.get_winner  #winner bc everyone else folded
       end
    else
       if @game.new_round && (params[:amt].to_i < @game.min_bet && params[:amt].to_i != 0)
         render :json => {:message => "Sorry. Your bet is below the minimum bet.", :result => false}
         return
       end
       if !@game.player_bets params[:amt].to_i
         render :json => {:message => "Sorry. You do not have enough money for that bet.", :result => false}
         return
       else
        @game.next_player
       end
    end

    if @game.table_even?
       if @game.next_card? 
         render :text => @game.to_json
         return
       else
         winner_id = @game.get_winner
         render :json => {:winner_id => winner_id}
       end
    else
       render :text => @game.to_json
       return
    end
  end

  def get_game
    if !current_user
      render :json => {"message" => "not logged in"}
    else
      game = Game.find(params[:id].to_i)
      render :text => game.to_json
    end
  end


  private 

  def get_cards_params
    params.require(:id)
  end

  def join_game_params
    params.require(:id)
  end

  def move_params
    params.require(:id, :amt, :action_type)
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
