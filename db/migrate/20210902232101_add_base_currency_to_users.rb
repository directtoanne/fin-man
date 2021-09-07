class AddBaseCurrencyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :base_currency, :string, default: "GBP"
  end
end
