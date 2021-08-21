class Goal < ApplicationRecord
  belongs_to :user

  def goal_percent_complete
    percent = 100 * current_amount.to_f / target_amount.to_f
    return percent.round(2)
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
    [
      "Car",
      "Debt",
      "Education",
      "Holiday",
      "Home",
      "Medical",
      "Savings",
      "Other"
    ]
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
end
