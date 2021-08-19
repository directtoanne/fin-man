class Goal < ApplicationRecord
  belongs_to :user

  def goal_percent_complete
    100 * current_amount.to_f / target_amount.to_f
  end

  def current_status
    if completed?
      "Complete"
    elsif target_due_date > Time.now
      "Overdue"
    elsif current_amount.zero?
      "Not Started"
    else
      "Active"
    end
  end
end
