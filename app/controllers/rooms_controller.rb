class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params.require(:room).permit(:image_room, :room_name, :content, :price, :address))
    
    if @room.save
      flash[:notice] = "施設を新規登録しました"
      redirect_to rooms_path
    else
      render "new"
    end  
  end
  
  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      flash[:notice] = "施設を削除しました"
      redirect_to rooms_path
    end
  end
end
