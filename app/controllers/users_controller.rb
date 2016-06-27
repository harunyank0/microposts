class UsersController < ApplicationController
  before_action :confirm_login, only: [:show, :edit, :update]
 
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def confirm_login
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :bio, :password, :password_confirmation)
  end
  
end
