class RoomsController < ApplicationController
  before_action :authenticate_user!

  # 検索アクション
  def search
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where('name LIKE ? OR detail LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  end

  # 新しい施設を作成するためのアクション
  def new
    @room = Room.new
  end

  # 施設をデータベースに保存するためのアクション
  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: '施設が作成されました。'
    else
      render :new
    end
  end

  # 施設の一覧を表示するためのアクション
  def index
    @rooms = current_user.rooms
  end

  # 施設の詳細を表示するためのアクション
  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build
    Rails.logger.debug "Room: #{@room}, Reservation: #{@reservation}"
  end

  # 施設情報の編集を行うためのアクション
  def edit
    @room = Room.find(params[:id])
  end

  def destroy
    @room = Room.find(params[:id])
    # 関連する予約があるかチェック
    if @room.reservations.exists?
      # 関連する予約がある場合は削除を中止
      redirect_to rooms_path, alert: '関連する予約が存在するため、削除できません。'
    else
      # 関連する予約がない場合は施設を削除
      @room.destroy
      redirect_to rooms_path, notice: '施設が削除されました。'
    end
  end

  private

  # ストロングパラメータ
  def room_params
    params.require(:room).permit(:name, :detail, :price, :address, :image)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
