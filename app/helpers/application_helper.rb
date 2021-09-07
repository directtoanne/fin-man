module ApplicationHelper
  # Usage - currency_pretty(amount: int, currency: "string GBP").format
  # https://github.com/RubyMoney/money
  def currency_pretty(amount:, currency: current_user.base_currency)
    if amount.to_s.include? '.0'
      amount = amount.to_s.gsub('.0', '.00')
    end

    if amount.to_s.include? '.'
      amount = amount.to_s.gsub('.', '')
    end

    money = Money.from_cents(amount, currency)
    return {format: money.format, amount: money, symbol: money.symbol}
  end
end
