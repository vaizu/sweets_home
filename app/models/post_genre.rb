class PostGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :post
end
