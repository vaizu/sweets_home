class RecipesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @recipe = @post.recipes.build
    @meterial = @post.meterials.build
    if @post.user == current_user
      render "new"
    else
      redirect_to post_path(@post.id)
    end
  end

  def create
    @post = Post.find(params[:post_id])
    #byebug
    if @post.update(recipe_params)
      @post.recipe_status = 0
      @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @recipe = Recipe.find(params[:id])
    @sum = 0
  end

  def edit
    @post = Post.find(params[:post_id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to post_recipe_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:post_id])
    if @post.update(recipe_params)
      redirect_to post_recipe_path(@post.id)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:post).permit(
    recipes_attributes:[:id, :recipe, :recipe_image, :_destroy],
    meterials_attributes:[:id, :meterial_name, :quantity, :_destroy])
  end
end