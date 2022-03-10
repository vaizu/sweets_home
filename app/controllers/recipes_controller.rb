class RecipesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @recipe = @post.recipes.build
    @meterial = @post.meterials.build
  end

  def create
    @post = Post.find(params[:post_id])

      recipe_params[:meterials_attributes].each do |k,value|
        if value["_destroy"] == "false"
          @post.meterials.create(meterial_name: value[:meterial_name], quantity: value[:quantity])
        end
      end
      recipe_params[:recipes_attributes].each do |k,value|
        if value["_destroy"] == "false"
          @post.recipes.create(recipe: value[:recipe], recipe_image: value[:recipe_image])
        end
      end
      redirect_to root_path
    #else
      #render :new
    #end
  end

  private

  def recipe_params
    params.require(:post).permit(
    recipes_attributes:[:recipe, :recipe_image, :_destroy],
    meterials_attributes:[:meterial_name, :quantity, :_destroy])
  end
end