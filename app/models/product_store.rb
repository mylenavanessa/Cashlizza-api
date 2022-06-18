class ProductStore < ApplicationRecord
  belongs_to :product
  belongs_to :store
  has_many :cashbacks, dependent: :destroy
end
