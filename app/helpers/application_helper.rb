require 'json'
require 'open-uri'

module ApplicationHelper
  # Usage - currency_pretty(amount: int, currency: "string GBP").format
  # https://github.com/RubyMoney/money
  def currency_pretty(amount:, currency: current_user.base_currency)
    amount *= 100
    money = Money.from_cents(amount, currency)
    return {format: money.format, amount: money, symbol: money.symbol}
  end

  def pluralize_string(data:, letter:)
    return letter.to_s if data.count > 1
  end

  def validate_data(data)
    data.negative? ? 0 : data
  end

  def convert_currency(input:, amount:, output: current_user.base_currency)
    result = []
    url = "/pair/#{input}/#{output}/#{validate_data(amount)}"
    resp = get_rate(url)
    result << {
      result: resp['result'],
      conversion_result: resp['conversion_result'],
      conversion_rate: resp['conversion_rate'],
      base_code: resp['base_code'],
      target_code: resp['target_code']
    }
  end

  private

  def get_rate(url_part)
    api_key = ENV["EXCHANGE_RATE_API_KEY"]
    url = "https://v6.exchangerate-api.com/v6/#{api_key}" + url_part
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
