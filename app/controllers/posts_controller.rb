class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @genre_ids = params[:post][:genre_ids]
      @genre_ids.each do |genre_id|
        if  genre_id != ""
          postgenre = PostGenre.new(post_id: @post.id, genre_id: genre_id.to_i)
          postgenre.save
        end
      end
      redirect_to post_path(@post)
    else
      # error
    end
  end

  def show
    @post = Post.find(params[:id])
    @genre = @post.post_genre_ids
    @comment = Comment.new
  end

  def index
    @posts = Post.page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    #アップデートが成功した場合
    if  @post.update(post_params)
    #タグを一度削除
      @post.post_genres.delete_all
    #再度タグ追加
      @genre_ids = params[:post][:genre_ids]
      @genre_ids.each do |genre_id|
      if  genre_id != ""
        postgenre = PostGenre.new(post_id: @post.id, genre_id: genre_id.to_i)
        postgenre.save
      end
    end
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/posts'
  end

  private
  def post_params
    params.require(:post).permit(:post_name,:post_introduction, :cooking_time, :cooking_cost, :recipe_status, :post_image)
  end
end
