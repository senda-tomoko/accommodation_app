class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def new
    @reservation = @room.reservations.build
  end

  def show
    # show アクション内で特別な処理は不要
    # @room と @reservation は before_action で設定済み
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to room_reservations_path(@room), notice: '予約が完了しました。'
    else
      render :new
    end
  end

  def index
    # ログインしているユーザーの予約のみを取得
    @reservations = current_user.reservations.includes(:room)
  end

  def edit
    # @reservation は set_reservation で設定されています
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to room_reservations_path(@reservation.room), notice: '予約が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to room_reservations_path(@room), notice: '予約が正常に削除されました。'
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = @room.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people)
  end
end
