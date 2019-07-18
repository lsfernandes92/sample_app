class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :logged_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login @user
      flash[:success] = "Welcome to the Sample app!"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Please log in first'
        redirect_to login_url
      end
    end
end
