class Genre < ApplicationRecord
  has_many :post_genre, dependent: :destroy
  has_many :post, through: :post, dependent: :destroy
end
