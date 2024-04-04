class RoomsController < ApplicationController
    def search
      area = params[:area]
      @rooms = Room.where('address LIKE ?', "%#{area}%")
      render 'search'
    end

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
      # ここでの current_user.rooms は、ログインしているユーザーに紐づく施設を取得します。
      # もしこの機能が必要ない、または current_user が未定義であれば、全ての施設を取得するなどの処理に変更してください。
      @rooms = Room.all # すべての施設を取得する例
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
