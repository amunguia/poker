class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  # GET /tables
  # GET /tables.json
  def index
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    else
      @tables = Table.all
    end
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    if !current_user
      render :file => "public/401.html", :status => :unauthorized
      return
    else
      @table = Table.find_by_id(params[:id])
      @room_name = Room.find_by_id(@table.room_id).name 
      @table.game ||= create_game
      @game_id = @table.game.id
      @player_position = @table.game.is_user_in_game? current_user
    end
  end

  def show_template
    @room_name = Room.find_by_id(Table.find_by_id(64).room_id)
  end

  # GET /tables/new
  def new
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end 
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end  
   end

  # POST /tables
  # POST /tables.json
  def create
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end 
    @table = Table.new(table_params)

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render action: 'show', status: :created, location: @table }
      else
        format.html { render action: 'new' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end 
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end 
    @table.destroy
    respond_to do |format|
      format.html { redirect_to tables_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    def create_game
      game = Game.new
      game.save
      game
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params[:table]
    end
end
