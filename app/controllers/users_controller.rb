class UsersController < ApplicationController
  #「ApplicationController」というクラスを継承して、新たに「UsersController」というクラスを作っている

  before_action :only_loggedin_users, only: [:index, :edit, :update, :destroy, :following, :follower]
  #editとupdateが実行される前にのみ、ログインしていない時にはlogin_urlを表示させる
  #before_actionとは、Controllerの全てのアクションが実行される前に何らかの処理を行う時に使用するもの
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def index #「http://localhost:3002/users/index」にアクセスするとindexのアクションメソッドが実行される
    @users = User.all #コントローラファイルにユーザーのデータを全て引っ張ってくる
    @users = User.paginate(page: params[:page], per_page: 10 )
  end
  

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Saved Successfully"
      redirect_to login_url
    else
      flash[:danger] = "Signup failed"
      render 'new' #newアクションに従って表示させる
    end
  end

  def show #Userクラスを用いて、idのユーザー情報を引っ張ってくる
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page:params[:page], per_page:12)
  end

  
  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to user_url
  end
 
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:session] = "Saved Successfully"
      redirecy_to @user
    else
      flash[:danger] = "Invalid content. Try Again."
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], per_page: 5)
    @all_users = @user.followed_users
    render 'show_follow'
  end

  def follower
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 5)
    @all_users = @user.followers
    render 'show_follow'
  end

private #クラスの外からは呼び出せない。同じインスタンス内でのみ、関数形式で呼び出せる。

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end

