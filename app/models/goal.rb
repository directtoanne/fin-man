class Goal < ApplicationRecord
  belongs_to :user

  def goal_percent_complete
    100 * current_amount.to_f / target_amount.to_f
  end
end
