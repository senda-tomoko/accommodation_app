class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show]
    before_action :set_user, only: [:edit_profile, :update_profile]

    def show
      @user = current_user
    end

    def edit_profile
      @user = current_user
    end


    def update_profile
      if @user.update(user_params)
        redirect_to user_profile_path, notice: 'プロフィールを更新しました。'
      else
        render :edit_profile
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :self_introduction, :icon_image)
    end
  end
