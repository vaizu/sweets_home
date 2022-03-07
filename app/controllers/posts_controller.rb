class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      postgenre = PostGenre.new(post_id: @post.id, genre_id: params[:post][:genre_id])
      postgenre.save
      redirect_to post_path(@post)
    else
      # error
    end
  end

  private
  def post_params
    params.require(:post).permit(:post_name,:post_introduction, :cooking_time, :cooking_cost, :recipe_status, :post_image)
  end
end
