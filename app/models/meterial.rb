class Meterial < ApplicationRecord
  belongs_to :post

  #validates :meterial_name, presence: true
  #validates :quantity, presence: true
  validates_presence_of :meterial_name
  validates_presence_of :quantity

end
