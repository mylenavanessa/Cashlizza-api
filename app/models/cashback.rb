class Cashback < ApplicationRecord
  belongs_to :product_store
  belongs_to :company
end
