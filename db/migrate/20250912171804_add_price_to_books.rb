class AddPriceToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :price, :decimal
  end
end
