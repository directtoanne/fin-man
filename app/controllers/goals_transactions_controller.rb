class GoalsTransactionsController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @goals_transaction = GoalsTransaction.new(goals_transaction_strong_params)
    authorize @goal
    @goals_transaction.goal = @goal
    @goals_transaction.time = Time.now
    @goals_transaction.save!
    @goal.current_amount += @goals_transaction.amount
    @goal.save!

    #below is automatic saving transaction added, perhaps format with diff color on show page
    @transaction = Transaction.new(account_id: @goals_transaction.account_id, recipient: "#{@goal.name} Goal", amount: -@goals_transaction.amount, time: @goals_transaction.time)
    @account = Account.find(@goals_transaction.account_id)
    authorize @account
    @transaction.account = @account
    @transaction.save!
    @account.balance -= @goals_transaction.amount
    @account.save!
    redirect_to goal_path(@goal)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goals_transaction.destroy
    redirect_to goal_path(@goal)
  end

  def index
    @goal = Goal.find(params[:goal_id])
    # authorize @goal
    @goals_transactions = policy_scope(GoalsTransaction).where(goal: @goal)
  end

  private
  
  def goals_transaction_strong_params
    params.require(:goals_transaction).permit(
      :goal_id, :time, :amount, :account_id
    )
  end
end
