class RecipesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @recipe = @post.recipes.build
    @meterial = @post.meterials.build
  end

  def create
    @post = Post.find(params[:post_id])
      #材料
      recipe_params[:meterials_attributes].each do |k,value|
        if value["_destroy"] == "false"
          @post.meterials.create(meterial_name: value[:meterial_name], quantity: value[:quantity])
        end
      end
      #レシピ手順
      recipe_params[:recipes_attributes].each do |k,value|
        if value["_destroy"] == "false"
          @post.recipes.create(recipe: value[:recipe], recipe_image: value[:recipe_image])
        end
      end
      redirect_to post_path(@post.id)
    #else
      #render :new
    #end
  end

  def show
    @post = Post.find(params[:post_id])
    @recipe = Recipe.find(params[:id])
    @sum = 0
  end

  def edit
    @post = Post.find(params[:post_id])
    #@recipe = @post.recipes.build
    #@meterial = @post.meterials.build
  end

  def update
    @post = Post.find(params[:post_id])
    @post.user_id = current_user.id
      #材料
      recipe_params[:meterials_attributes].each do |k,value|
        # IDが存在しない場合新しく作成
        unless Meterial.exists?(value["id"])
          if value["_destroy"] == "false"
            material = @post.meterials.create(meterial_name: value[:meterial_name], quantity: value[:quantity])
            value["id"] = material.id
          end
        end
        #アップデート
        if value["_destroy"] == "false"
          m = Meterial.find(value["id"])
          m.update!(meterial_name: value[:meterial_name], quantity: value[:quantity])
          #削除ボタンを押された場合データ削除
        elsif value["_destroy"] == "1"
          Meterial.find(value["id"]).destroy!
        end
      end
      #レシピ手順
      recipe_params[:recipes_attributes].each do |k,value|
        # IDが存在しない場合新しく作成
        unless Recipe.exists?(value["id"])
          if value["_destroy"] == "false"
            recipe = @post.recipes.create(recipe: value[:recipe], recipe_image: value[:recipe_image])
            value["id"] = recipe.id
          end
        end
        #アップデート
        if value["_destroy"] == "false"
          m = Recipe.find(value["id"])
          m.update!(recipe: value[:recipe], recipe_image: value[:recipe_image])
        #削除ボタンを押された場合データ削除
        elsif value["_destroy"] == "1"
          Recipe.find(value["id"]).destroy!
        end
      end
      redirect_to post_recipe_path(@post.id)
    #else
      #render :new
    #end
  end



  private

  def recipe_params
    params.require(:post).permit(
    recipes_attributes:[:id, :recipe, :recipe_image, :_destroy],
    meterials_attributes:[:id, :meterial_name, :quantity, :_destroy])
  end
end