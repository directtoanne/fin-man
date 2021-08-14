class AddUserIdToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :user, null: false, foreign_key: true
  end
end
