class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :currency
      t.string :bank_name
      t.integer :account_number
      t.integer :sort_code
      t.decimal :balance

      t.timestamps
    end
  end
end
