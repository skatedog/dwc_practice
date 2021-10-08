class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @user = User.find(current_user.id)
    @users = User.with_attached_image
  end

  def show
    if params[:id] == current_user.id
      @user = User.find(current_user.id)
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = current_user
  end

  def update
    p @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :introduction, :image)
    end

    def ensure_correct_user
      user = User.find(params[:id])
      unless user == current_user
        redirect_to user_path(current_user)
      end
    end
end
