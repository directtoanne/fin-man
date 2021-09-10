require 'json'
require 'open-uri'

class UsersController < ApplicationController
  def dashboard
    @accounts = current_user.accounts
    @goals = current_user.goals
    # authorize @accounts - one is enough, since it authorises the (current) user (in this case, which is not the way to do that)
    authorize @goals
    @accounts_balance = accounts_total
    @goals_total = goals_total
    @goals_data = chart_data(@goals)
    @accounts_data = chart_data(@accounts)
  end

  def goals_total
    calculate_goals_total
  end

  def accounts_total
    convert_account_balances
  end

  def chart_data(data)
    res = []
    if data.model_name == 'Goal'
      data.each { |goal| res << { name: goal.name, amount: goal.current_amount } }
    elsif data.model_name == 'Account'
      data.each { |account| res << { name: account.bank_name, amount: account.balance } }
    end
    puts res
    return res
  end

  private

  def calculate_goals_total
    goals_total = 0
    if @goals != nil? || @goals.count.positive?
      @goals.each do |goal|
        goals_total += goal.current_amount
      end
    end
    return goals_total
  end

  def convert_account_balances
    accounts_total = 0
    if @accounts != nil? || @accounts.count.positive?
      @accounts.each do |account|
        if current_user.base_currency == account.currency
          accounts_total += account.balance
        else
          api_key = ENV["EXCHANGE_RATE_API_KEY"]
          url = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{current_user.base_currency}/#{account.currency}/#{account.balance}"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          response_obj = JSON.parse(response)
          accounts_total += response_obj['conversion_result'].round(2)
        end
      end
      return accounts_total
    end
  end
end
