class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :amount
      t.string :recipient
      t.datetime :time

      t.timestamps
    end
  end
end
