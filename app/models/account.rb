class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :goals_transactions, dependent: :destroy

  validates :user_id, :bank_name, :account_number, :sort_code, :balance, presence: true
  validates :sort_code, length: { is: 6, message: "must be 6 digits long" }
  validates :account_number, length: { is: 8, message: "must be 8 digits long" }

  def sort_code_pretty
    array = sort_code.to_s.scan(/../)
    array.map! { |d| d + "-" }
    array.join.chop
  end

  def account_categories
    ["HSBC", "Barclays", "Lloyds", "Natwest", "Santander", "Halifax", "Nationwide", "TSB", "Royal Bank of Scotland", "Ulster", "First Direct", "Monzo", "Starling", "US Bank", "Other"]
  end

  def account_categories_icon
    case bank_name
    when "HSBC" then "hsbc--mark.svg"
    when "Barclays" then "barclays--mark.svg"
    when "Lloyds" then "lloyds--mark.svg"
    when "Natwest" then "natwest--mark.svg"
    when "Santander" then "santander--mark.svg"
    when "Halifax" then "halifax.svg"
    when "Nationwide" then "nationwide--mark.svg"
    when "TSB" then "tsb--mark.svg"
    when "Royal Bank of Scotland" then "bank-of-scotland--mark.svg"
    when "Ulster" then "ulster--mark.svg"
    when "First Direct" then "firstdirect--mark.svg"
    when "Monzo" then "monzo--mark.png"
    when "Starling" then "starling--mark.png"
    when "US Bank" then "US-Bank.png"
    else
      "other--mark.png"
    end
  end
end
