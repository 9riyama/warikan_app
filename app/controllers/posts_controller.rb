class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      pay_name: params[:pay_name],
      content: params[:content],
      payment: params[:payment],
      user_id: @current_user.id,
      categories_id: params[:categories_id][:keys].to_i, 
      pay_month:  Time.zone.local(params[:pay_month]["date(1i)"].to_i, 
                                 params[:pay_month]["date(2i)"].to_i, 
                                 params[:pay_month]["date(3i)"].to_i)
    )
    
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
