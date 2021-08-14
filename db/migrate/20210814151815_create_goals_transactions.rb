class CreateGoalsTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :goals_transactions do |t|
      t.references :goal, null: false, foreign_key: true
      t.decimal :amount
      t.datetime :time
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
