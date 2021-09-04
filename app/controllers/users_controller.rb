require 'json'
require 'open-uri'

class UsersController < ApplicationController
  def dashboard
    @accounts = current_user.accounts
    @goals = current_user.goals
    # authorize @accounts - one is enough, since it authorises the (current) user (in this case, which is not the way to do that)
    authorize @goals
    @accounts_balance = accounts_total
  end

  def accounts_total
    convert_account_balances
  end

  private

  def convert_account_balances
    total = 0
    if @accounts
      @accounts.each do |account|
        if current_user.base_currency == account.currency
          total += account.balance
        else
          url = "https://v6.exchangerate-api.com/v6/6d334fcfc695911900bdb698/pair/#{current_user.base_currency}/#{account.currency}/#{account.balance}"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          response_obj = JSON.parse(response)
          total += response_obj['conversion_result']
        end
      end
      return total
    end
  end
end
