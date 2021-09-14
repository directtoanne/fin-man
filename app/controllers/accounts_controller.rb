class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :destroy]
  after_action :authorize_acc, only: [:new]

  def index
    @accounts = policy_scope(Account)
  end

  def show
    @transaction = Transaction.new
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_strong_params)
    @account.user_id = current_user.id
    authorize_acc
    if @account.save
      redirect_to account_path(@account), notice: 'Account Sucessfully created, Lets get saving!!'
    else
      redirect_to new_account_path, alert: 'Please try adding your account again'
    end
  end

  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: 'Account Sucessfully destroyed'
    else
      redirect_to accounts_path, alert: 'Please try deleting your account again'
    end
  end

  private

  def set_account
    @account = Account.find_by_id params[:id]
    if @account.blank?
      redirect_to accounts_path, alert: 'The selected Account is not found, please select a different account'
    else
      authorize_acc
    end
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
