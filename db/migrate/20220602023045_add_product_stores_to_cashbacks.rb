class AddProductStoresToCashbacks < ActiveRecord::Migration[5.1]
  def change
    add_reference :cashbacks, :product_store, index: true
  end
end
