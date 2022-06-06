class AddProductStoreToCashbacks < ActiveRecord::Migration[5.1]
  def change
    remove_column :cashbacks, :product_store_id
  end
end
