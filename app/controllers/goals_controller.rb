class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  after_action :authorize_goal, only: [:new]

  def index
    @goals = policy_scope(Goal)
  end

  def show
    set_goal
    ## calculate goal percentage
    @goal_percent = 100 * @goal.current_amount.to_f / @goal.target_amount.to_f
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
end
