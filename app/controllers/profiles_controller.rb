class ProfilesController < ApplicationController

    before_action :sign_in_required, only: [:show]
    def index
    end  
  
    def show
      @user = current_user
    end

    def edit
      @user = current_user
    end 

    def update
        @user = current_user
        if @user.update(params.require(:user).permit(:avatar, :name, :self_introduction))
          flash[:notice] = "「#{@user.id}」のプロフィールを更新しました"
          redirect_to :back
        else
          render "edit"
        end
    end
  end