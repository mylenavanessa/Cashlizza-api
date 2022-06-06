class ChangeColunmCashback < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :cashbacks, column: :product_id
    remove_foreign_key :cashbacks, column: :store_id

    add_reference :cashbacks, :product_store
  end
end
