require 'json'
class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  after_action :authorize_goal, only: [:new]

  def index
    @goals = policy_scope(Goal)
    @goal_status = goals_status_count
    @goals_total_count = goals_total
    @goals_data = goals_data
  end

  def show
    @goals_transaction = GoalsTransaction.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_strong_params)
    @goal.user_id = current_user.id
    authorize_goal
    @goal.save ? (redirect_to goal_path(@goal)) : (render :new)
  end

  def edit; end

  def update
    @goal.update(goal_strong_params)
    redirect_to goals_path
  end

  def destroy
    @goal.destroy
    redirect_to goals_path
  end

  private

  def all_user_goals
    Goal.all.where(user_id: 1)
  end

  def set_goal
    @goal = Goal.find(params[:id])
    authorize_goal
  end

  def authorize_goal
    authorize @goal
  end

  def goal_strong_params
    params.require(:goal).permit(
      :name, :subject, :category, :target_amount, :target_due_date, :start_date, :completed
      )
  end

  def goals_status_count
    goal_status = []
    goals = Goal.all.where(user_id: current_user.id)
    goals.each do |goal|
      goal_status << goal.current_status
    end
    return goal_status
  end

  def goal_transactions
    goal_trans = []
    goals = all_user_goals
    goals.each do |goal|
      goal_trans << goal.goals_transactions
    end
    return goal_trans
  end

  def goals_total
    total = 0
    all_user_goals.each do |goal|
      total += goal.current_amount
    end
    return total
  end

  def goals_data
    data = []
    goals = all_user_goals
    goals.each do |goal|
      data << { goal_name: goal.name, goal_value: goal.current_amount }
    end
    return data
  end
end
