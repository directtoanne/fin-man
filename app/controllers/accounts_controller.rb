class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :destroy]
  after_action :authorize_acc, only: [:new]

  def index
    @accounts = policy_scope(Account)
  end

  def show; end

  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(account_strong_params)
    @account.user_id = current_user.id
    authorize_acc
    @account.save ? (redirect_to account_path(@account)) : (render :new)
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private

  def set_account
    @account = Account.find(params[:id])
    authorize_acc
  end

  def authorize_acc
    authorize @account
  end
  
  def account_strong_params
    params.require(:account).permit(
      :user_id, :currency, :bank_name, :account_number, :sort_code, :balance
    )
  end
end
