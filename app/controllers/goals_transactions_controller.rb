class GoalsTransactionsController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @goals_transaction = GoalsTransaction.new(goals_transaction_strong_params)
    authorize @goal
    @goals_transaction.goal = @goal
    @goals_transaction.save!
    @goal.current_amount =+ @goals_transaction.amount
    @goal.save!
    redirect_to goal_path(@goal)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goals_transaction.destroy
    redirect_to goal_path(@goal)
  end

  private
  
  def goals_transaction_strong_params
    params.require(:goals_transaction).permit(
      :goal_id, :time, :amount, :account_id
    )
  end
end
