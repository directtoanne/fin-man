class TransactionsController < ApplicationController
  def create
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new(transaction_strong_params)
    authorize @account
    @transaction.account = @account
    @transaction.save!
    @account.balance -= @transaction.amount
    @account.save!
    redirect_to account_path(@account)
  end

  def destroy
    @account = Account.find(params[:id])
    @transaction.destroy
    redirect_to account_path(@account)
  end

  def index
    @account = Account.find(params[:account_id])
    # authorize @account
    @transactions = policy_scope(Transaction).where(account: @account)
  end

  private
  
  def transaction_strong_params
    params.require(:transaction).permit(
      :account_id, :recipient, :time, :amount
    )
  end
end
