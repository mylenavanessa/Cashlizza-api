class CreateCashbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :cashbacks do |t|
      t.string :url
      t.decimal :percentage
      t.references :product, foreign_key: true
      t.references :store, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
