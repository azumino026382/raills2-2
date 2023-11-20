class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit]
  def index
  end 

  def show
    @user = current_user
  
  end

  def edit
    @user = current_user
  end  
end
