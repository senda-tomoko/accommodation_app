class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :show]
  skip_before_action :authenticate_user!, only: [:new, :show]

  before_action :set_room, only: [:show, :new, :create, :confirm_new, :edit, :update, :destroy]
  before_action :set_reservation, only: [:new, :create, :confirm_new, :edit, :update, :destroy]


  def new
    @reservation = @room.reservations.build
  end

  def show
    @reservation = Reservation.find(params[:id])

    # デバッグ用のログ出力
    Rails.logger.debug "チェックイン: #{@reservation.check_in}, チェックアウト: #{@reservation.check_out}, 人数: #{@reservation.number_of_people}"

    # 宿泊日数の計算
    nights = (@reservation.check_out - @reservation.check_in).to_i
    Rails.logger.debug "宿泊日数: #{nights}"

    # 合計金額の計算
    @total_price = nights * @reservation.room.price * @reservation.number_of_people
    Rails.logger.debug "合計お支払い金額: #{@total_price}"
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

  def confirm_new
    @reservation = @room.reservations.build(reservation_params)

    Rails.logger.debug "Reservation Params: #{reservation_params.inspect}"
    Rails.logger.debug "Check-in: #{@reservation.check_in}, Check-out: #{@reservation.check_out}"

    if @reservation.check_in && @reservation.check_out
      @nights = (@reservation.check_out - @reservation.check_in).to_i
      @total_price = @nights * @reservation.room.price * @reservation.number_of_people
    else
      # 適切なエラーハンドリングをここに実装
      Rails.logger.debug "Check-in or Check-out is nil"
    end
  end

  private

  def set_room
    @room = Room.find_by(id: params[:room_id])
    unless @room
      redirect_to root_path, alert: "Room not found."
    end
  end

  def set_reservation
    # params[:id]が存在する場合のみ、@reservationを設定
    if params[:id]
      @reservation = @room.reservations.find(params[:id])
    end
    # params[:id]が存在しない場合は、このメソッド内で何も行わない。
    # 新規予約の場合は、通常、@reservation は新規フォームまたはconfirm_newアクション内で別途初期化される。
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id)
  end
end
