module ApplicationHelper
  # Usage - currency_pretty(amount: int, currency: "string GBP").format
  # https://github.com/RubyMoney/money
  def currency_pretty(amount:, currency: current_user.base_currency)
    amount *= 100
    money = Money.from_cents(amount, currency)
    return {format: money.format, amount: money, symbol: money.symbol}
  end
end
