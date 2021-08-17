class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :goals_transactions

  validates :user_id, :currency, :bank_name, :account_number, :sort_code, presence: true
end
