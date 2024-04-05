class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = User.find(params[:id])
    end

    def edit_profile
      @user = current_user
    end

    def update_profile
      @user = current_user
      if @user.update(user_params)
        redirect_to root_path, notice: 'プロフィールが更新されました'
      else
        render :edit_profile
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :self_introduction, :icon_image)
    end
  end
