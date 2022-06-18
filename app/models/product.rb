class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :product_stores, dependent: :destroy
end
