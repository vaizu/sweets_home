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
    # ActiveRecord::Base.transaction do
    #   @post = Post.find(params[:post_id])
    #     #材料
    #     recipe_params[:meterials_attributes].each do |k,value|
    #       if value["_destroy"] == "false"
    #         @post.meterials.create!(meterial_name: value[:meterial_name], quantity: value[:quantity])
    #       end
    #     end
    #     #レシピ手順
    #     recipe_params[:recipes_attributes].each do |k,value|
    #       if value["_destroy"] == "false" && value[:recipe].present?
    #         @post.recipes.create!(recipe: value[:recipe], recipe_image: value[:recipe_image])
    #       end
    #     end
    #   @post.recipe_status = 0
    #   @post.save
    # end
    #   redirect_to post_path(@post.id)
    # rescue => e
    #   render :new
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
    #@recipe = @post.recipes.build
    #@meterial = @post.meterials.build
  end

  def update
    @post = Post.find(params[:post_id])
    if @post.update(recipe_params)
      redirect_to post_recipe_path(@post.id)
    else
      render :edit
    end
    # @post = Post.find(params[:post_id])
    # @post.user_id = current_user.id
    # #材料
    # recipe_params[:meterials_attributes].each do |k,value|
    #   # IDが存在しない場合新しく作成
    #   unless Meterial.exists?(value["id"])
    #     if value["_destroy"] == "false"
    #       if material = @post.meterials.create(meterial_name: value[:meterial_name], quantity: value[:quantity])
    #         value["id"] = material.id
    #       else
    #         render :edit
    #       end
    #     end
    #   end
    #   #アップデート
    #   if value["_destroy"] == "false"
    #     m = Meterial.find(value["id"])
    #     if m.update!(meterial_name: value[:meterial_name], quantity: value[:quantity])
    #     else
    #       render :edit
    #     end
    #     #削除ボタンを押された場合データ削除
    #   elsif value["_destroy"] == "1"
    #     Meterial.find(value["id"]).destroy!
    #   end
    # end

    # #レシピ手順
    # recipe_params[:recipes_attributes].each do |k,value|
    #   # IDが存在しない場合新しく作成
    #   unless Recipe.exists?(value["id"])
    #     if value["_destroy"] == "false"
    #       if recipe = @post.recipes.create(recipe: value[:recipe], recipe_image: value[:recipe_image])
    #         value["id"] = recipe.id
    #       else
    #         render :edit
    #       end
    #     end
    #   end
    #   #アップデート
    #   if value["_destroy"] == "false"
    #     m = Recipe.find(value["id"])
    #     #byebug
    #     if value[:recipe_image].nil?
    #       if m.update!(recipe: value[:recipe])
    #       else
    #         render :edit
    #       end
    #     else
    #       m.update!(recipe: value[:recipe], recipe_image: value[:recipe_image])
    #     end
    #   #削除ボタンを押された場合データ削除
    #   elsif value["_destroy"] == "1"
    #     Recipe.find(value["id"]).destroy!
    #   end
    # end
    # redirect_to post_recipe_path(@post.id)
  end



  private

  def recipe_params
    params.require(:post).permit(
    recipes_attributes:[:id, :recipe, :recipe_image, :_destroy],
    meterials_attributes:[:id, :meterial_name, :quantity, :_destroy])
  end
end