class AddEndDateToLoans < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :end_date, :date unless column_exists?(:loans, :end_date)
  end
end
