class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  def index
    @goals = Goal.all
  end

  def show; end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_strong_params)
    @goal.user_id = current_user.id
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
  end

  def goal_strong_params
    params.require(:goal).permit(:name, :target_amount, :target_due_date, :start_date)
  end
end
