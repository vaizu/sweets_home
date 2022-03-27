class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :post

  validates_presence_of :recipe

  before_save :attach_default_image, unless: :recipe_image_attached?


  def get_recipe_image
    recipe_image.variant(resize_to_limit: [300, 300]).processed
  end

  private

  def recipe_image_attached?
    recipe_image.attached?
  end

  def attach_default_image
    file_path = Rails.root.join('app/assets/images/no_image1.jpg')
    recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
end
