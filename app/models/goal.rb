class Goal < ApplicationRecord
  belongs_to :user
  has_many :goals_transactions, dependent: :destroy

  def goal_complete?
    completed?
  end

  def mark_goal_complete
    complete_goal
  end

  def goal_days_till_due
    due = Date.parse target_due_date.to_s
    now = Date.parse Time.now.to_s
    (due - now).to_i
  end

  def goal_percent
    percent = 100 * current_amount.to_f / target_amount.to_f
    if percent.to_i > 100
      return 100.to_f
    else
      return percent
    end
  end

  # 34.679823015 - 35
  def goal_percent_complete
    goal_percent.round
  end

  # 34 - 0.34
  def goal_percent_decimal
    (goal_percent / 100).round(2)
  end

  def current_status
    goal_status
  end

  def pretty_date(time_date)
    time_date.strftime("%a %d-%b-%y")
  end

  def progress_color
    if current_status == "Overdue"
      "bg-danger"
    else
      "bg-success"
    end
  end

  # Set categorys for te Goals
  def goal_categories
    ["Car", "Debt", "Education", "Holiday", "Home", "Medical", "Savings", "Wedding", "Other"]
  end

  def goal_categories_icon
    case category
    when "Car" then "fas fa-car"
    when "Debt" then "fas fa-file-invoice-dollar"
    when "Education" then "fas fa-user-graduate"
    when "Holiday" then "fas fa-umbrella-beach"
    when "Home" then "fas fa-home"
    when "Medical" then "fas fa-briefcase-medical"
    when "Saving" then "fas fa-piggy-bank"
    when "Wedding" then "fas fa-glass-cheers"
    else
      "fas fa-question"
    end
  end

  private

  def goal_status
    if completed?
      "Complete"
    elsif target_due_date.past?
      "Overdue"
    elsif current_amount == 0.to_f
      "Not Started"
    else
      "Active"
    end
  end

  def complete_goal
    completed = true unless completed?
  end
end
