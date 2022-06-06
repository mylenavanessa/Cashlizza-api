class ChangeColunm < ActiveRecord::Migration[5.1]
  def change
    remove_column :cashbacks, :product_id
    remove_column :cashbacks, :store_id
    remove_column :products, :price
  end
end
