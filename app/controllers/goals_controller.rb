class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  after_action :authorize_goal, only: [:new]

  def index
    @goals = policy_scope(Goal)
    @goal_status = goals_status_count
  end

  def show; end

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

  def set_goal
    @goal = Goal.find(params[:id])
    authorize_goal
  end

  def authorize_goal
    authorize @goal
  end

  def goal_strong_params
    params.require(:goal).permit(
      :name, :target_amount, :target_due_date, :start_date
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
end
