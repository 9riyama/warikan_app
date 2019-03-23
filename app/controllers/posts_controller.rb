class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.page(params[:page]).per(5).where(user_id: params[:id]).order('pay_month DESC').order('updated_at DESC')
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def month_index
   @monthly_posts = Post.where(user_id: params[:id]).group("pay_month").order(pay_month: "desc")
  end
  
  def monthly_total
   @user = User.find_by(id: params[:id])
   @posts = Post.where(user_id: params[:id]).where(pay_month: params[:pay_month])
   @total = @posts.sum("payment")
   @warikan = @total / 2
   @user_total = @posts.where(pay_name: @user.name).sum("payment")
   @user_pay = @user_total - @warikan
   @partner_total = @posts.where(pay_name: @user.partner_name).sum("payment")
   @partner_pay = @partner_total - @warikan
   @chart = [[@user.name, @user_total], [@user.partner_name, @partner_total]]
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
      category_id: params[:category_id][:keys].to_i, 
      pay_month:  Time.zone.local(params[:pay_month]["date(1i)"].to_i, 
                                 params[:pay_month]["date(2i)"].to_i, 
                                 params[:pay_month]["date(3i)"].to_i)
    )
    
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index/#{@current_user.id}")
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
      redirect_to("/posts/index/#{@current_user.id}")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index/#{@current_user.id}")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index/#{@current_user.id}")
    end
  end
  
end
