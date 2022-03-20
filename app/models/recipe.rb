class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :post

  #validates :recipe, presence: true
  validates_presence_of :recipe


  def get_recipe_image
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    recipe_image.variant(resize_to_limit: [100, 100]).processed
  end
end
