class Goal < ApplicationRecord
  belongs_to :user

  def goal_percent_complete
    100 * current_amount.to_f / target_amount.to_f
  end

  def current_status
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
end
