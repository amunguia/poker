class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    if current_user
      @rooms = Room.all
      @num  = Array.new(3,0)
      i = 0
      k = 0
      basic = Room.find_by_name("Basic Room")

      basic = Table.where(room_id: basic.id)

      basic.each do |item|
        @num[0]  += (item.get_usernames).size
      end

      medium = Room.find_by_name("Medium Room")
      medium = Table.where(room_id: medium.id)

      medium.each do |item|
        @num[1]  += (item.get_usernames).size
      end

      high = Room.find_by_name("High Rollers Room")
      high = Table.where(room_id: high.id)
      high.each do |item|
        @num[2]  += (item.get_usernames).size
      end

      @games = current_games

      @admin = current_user.user_level == 0
    else
      redirect_to log_in_path, notice: "Must Login to Play"
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    if current_user
        @tables = Table.find_all_by_room_id(params[:id])
     # puts @tables
    else
      redirect_to log_in_path, notice: "Must Login to Play"
      return
    end
  end

  # GET /rooms/new
  def new
    if current_user.user_level != 0
      render :file => "public/403.html", :status => :unauthorized
      return
    end
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    if current_user.user_level != 0
      render :file => "public/403.html", :status => :unauthorized
      return   
    end
  end

  # POST /rooms
  # POST /rooms.json
  def create
    if current_user.user_level != 0
      render :file => 'public/403.html', :status => :unauthorized
      return
    end

    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render action: 'show', status: :created, location: @room }
      else
        format.html { render action: 'new' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
   if current_user.user_level != 0
      render :file => "public/403.html", :status => :unauthorized
      return
    end

    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    if current_user.user_level != 0
      render :file => "public/401.html", :status => :unauthorized
      return
    end 

   @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params[:room]
    end
end
