class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:show, :edit, :update]}
  
  def index
    @users = User.all
  end

  
  def show
    @user = User.find(params[:id])
    @users = @user.posts.page(params[:page]).per(5).where(pay_name: @user.name).order('updated_at DESC')
  end
  
  def partner_pay
    @user = User.find(params[:id])
    @users = @user.posts.page(params[:page]).per(5).where(pay_name: @user.partner_name).order('updated_at DESC')
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      partner_name: "パートナー",
      email: params[:email],
      image_name: "default_user.jpg",
      image_partner: "default_partner.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.partner_name = params[:partner_name]
    @user.email = params[:email]
    
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image_name]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if params[:image_partner]
      @user.image_partner = "#{@user.id}_1.jpg"
      image = params[:image_partner]
      File.binwrite("public/user_images/#{@user.image_partner}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end
  
  def login
    # メールアドレスのみを用いて、ユーザーを取得するように書き換えてください
    @user = User.find_by(email: params[:email])
    # if文の条件を&&とauthenticateメソッドを用いて書き換えてください
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/users/login_form")
  end
  

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/#{@current_user.id}")
    end
  end
  
end
