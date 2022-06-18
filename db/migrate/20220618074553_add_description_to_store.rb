class AddDescriptionToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :description, :string
  end
end
