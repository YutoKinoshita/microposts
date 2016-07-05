class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end

  
  def new
    @user = User.find(params[:id])
    @user = User.new
  end 
  
  def edit
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

  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to user_path(@user) , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
    @title = 'Followings'
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
    @title = 'Followers'
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :age, :area, :profile)
  end

  def correct_user
    redirect_to root_path if @user != current_user
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end