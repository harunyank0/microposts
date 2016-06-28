class UsersController < ApplicationController
  before_action :set_params, only: [:followers, :followings, :show, :edit, :update]
  before_action :confirm_login, only: [:edit, :update]
  before_action :logged_in_user, only: :show
 
  
  def show
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
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings"
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.follower_users
    render 'show_follow'
  end
  
#followings_user GET    /users/:id/followings(.:format) users#followings
#followers_user GET    /users/:id/followers(.:format)  users#followers

#has_many :following_users, through: :following_relationships, source: :followed
#has_many :follower_users, through: :follower_relationships, source: :follower

  private

  def confirm_login
    redirect_to root_path if @user != current_user
  end
  
  def set_params
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :bio, :password, :password_confirmation)
  end
  
end
