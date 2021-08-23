class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :goals_transactions

  validates :user_id, :currency, :bank_name, :account_number, :sort_code, :balance, presence: true
end
