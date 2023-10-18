class ReservationsController < ApplicationController
  def index
    @user = current_user
    @reservations = @user.reservations
  end

  def new
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :person_num))
    @reservation.days = ((@reservation.end_date).to_i - (@reservation.start_date).to_i)/60/60/24
    @reservation.total_price = ((@room.price).to_i * (@reservation.person_num).to_i * (@reservation.days).to_i)
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(params.require(:reservation).permit(:start_date, :end_date, :person_num, :room_id, :user_id, :days, :total_price))  #  ●モデルに定義するのこれでいいのか？モデルの定義必要なカラムとSQLの書き方とlikeテーブル
    if params[:back] || !@reservation.save
      render template: "rooms/show" and return
    else  
      flash[:notice] = "予約が完了しました"
      redirect_to reservations_path
    end
  end

  def show
    @reservation = Reservation.find(params[:room_id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = Room.find(params[@reservation.room_id])
  end

  def edit_confirm
    @reservation = Reservation.find(params[:id])
    @days = (@reservation.end_date - @reservation.start_date).to_i
    @total_price = @room.price * @reservation.person_num * @days
    @reservation.attributes = reservation_params
    render :edit if @reservation.invalid?
  end

  def update
    @reservation = Reservation.find(params[:id])
      if params[:back] || !@reservation.update(reservation_params)
        render 'edit'
      else
        redirect_to reservations_url, notice: "予定を編集しました。"
      end
  end



private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :days, :person_num, :total_price, :room_id)
  end 


end
