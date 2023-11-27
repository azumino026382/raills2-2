class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :destroy]
  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params.require(:room).permit(:room_image, :room_name, :content, :price, :address))
    
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

  def search
    if params[:area].present?
      @rooms = Room.where('address LIKE ?', "%#{params[:area]}%")
      @result_count = Room.where('address LIKE ?', "%#{params[:area]}%").count
    elsif params[:keyword].present?
      @rooms = Room.where('room_name LIKE ?', "%#{params[:keyword]}%").or(Room.where('content LIKE ?', "%#{params[:keyword]}%"))
      @result_count = Room.where('room_name LIKE ?', "%#{params[:keyword]}%").or(Room.where('content LIKE ?', "%#{params[:keyword]}%")).count
    else
      @rooms = Room.none
    end
  end
end

