class AddFileToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :file, :string
  end
end
