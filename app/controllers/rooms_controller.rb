class RoomsController < ApplicationController
    def new
      @room = Room.new
    end

    def create
      @room = Room.new(room_params)
      if @room.save
        redirect_to @room, notice: '施設が作成されました。' # フラッシュメッセージの設定
      else
        render :new
      end
    end

    def index
      @rooms = Room.all # すべての部屋のレコードを取得して@roomsに割り当てる
    end

    def show
      @room = Room.find(params[:id])
    end

    def edit
      @room = Room.find(params[:id])
    end

    private

    def room_params
      params.require(:room).permit(:name, :detail, :price, :address, :image)
    end
  end
