class UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      render :show
    else
      render json: { error: @user.errors.full_messages }, status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
