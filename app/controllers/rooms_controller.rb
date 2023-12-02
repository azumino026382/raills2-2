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

  def search; end

  def search
    if params[:search_area].present? && params[:search_free].blank?
      @rooms = Room.search_area(params[:search_area])
      @result_count = @rooms.count
    elsif params[:search_area].blank? && params[:search_free].present?
      @rooms = Room.search_free(params[:search_free])
      @result_count = @rooms.count
    end    
  end
end

