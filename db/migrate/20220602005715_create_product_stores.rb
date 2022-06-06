class CreateProductStores < ActiveRecord::Migration[5.1]
  def change
    create_table :product_stores do |t|
      t.decimal :price
      t.references :product, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
