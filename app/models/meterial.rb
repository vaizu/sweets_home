class Meterial < ApplicationRecord
  belongs_to :post

  validates :meterial_name, presence: true
  validates :quantity, presence: true
end
