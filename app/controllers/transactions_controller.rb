class TransactionsController < ApplicationController
  def create
    @account = Account.find(params[:account_id])
    if params[:file].present?
      require 'csv' 
      file = params[:file] 
      CSV.foreach(file.path, headers: true, converters: :date) do |row| 
        @transaction = Transaction.new(recipient: row["recipient"], amount: row["amount"], time: row["time"])
        authorize @account
        @transaction.account = @account
        @transaction.save!
        @account.balance += @transaction.amount
        @account.save!
      end  
    else
      @transaction = Transaction.new(transaction_strong_params)
      authorize @account
      @transaction.account = @account
      @transaction.save!
      @account.balance += @transaction.amount
      @account.save!
    end
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
      :account_id, :recipient, :time, :amount, :file
    )
  end
end
