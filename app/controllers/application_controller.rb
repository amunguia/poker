class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :current_games
  
  private 
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_games
    @games = []
    if current_user != nil
      @games<< extract_games_in_progress(
        Game.where(p1: current_user.id))
      @games<< extract_games_in_progress(
        Game.where(p2: current_user.id))
      @games<< extract_games_in_progress(
        Game.where(p3: current_user.id))
      @games<< extract_games_in_progress(
        Game.where(p4: current_user.id))
    end
    @games
  end

  private

  def extract_games_in_progress(games)
    games = []
    games.each do |g|
      if g.winner_id == nil
        games<< g
      end
    end
    games
  end

end
