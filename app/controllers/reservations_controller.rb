class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:edit, :update, :destroy]

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to @room, notice: '予約が完了しました。'
    else
      render :new
    end
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(room: @room)
    # 他の必要な処理があればここに記述
  end


  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def edit
    # @reservationはset_reservationで設定されています
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservation_path, notice: '予約が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservation_path, notice: '予約が削除されました。'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id)
  end
end
