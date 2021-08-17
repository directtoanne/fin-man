class AccountsController < ApplicationController
  def index
    @accounts = Account.where(user_id: current_user.id)
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(account_strong_params)
    @account.user_id = current_user.id
    @account.save ? (redirect_to account_path(@account)) : (render :new)
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end
  
  def account_strong_params
    params.require(:account).permit(
      :user_id, :currency, :bank_name, :account_number, :sort_code
    )
  end
end
