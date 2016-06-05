class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit]
  before_filter :load_post, only: [:destroy, :edit]


  def index
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to @post.user
    else
      render 'edit'
    end
  end


  def destroy
    @post.destroy
    redirect_to :back
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private
    def post_params
      params.require(:post).permit(:title, :context)
      
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    def load_post
      @post = current_user.admin ? Post.find(params[:id]) : current_user.posts.find(params[:id])
    end
 

end