class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :show, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def edit

  end

  def show

  end

  def update
    [:password, :password_confirmation, :avatar].each {|x| params.delete(x) if x.blank?}
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, flash: { message: 'Update failed.'}
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :avatar)
  end

end
