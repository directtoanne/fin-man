class GoalsTransaction < ApplicationRecord
  belongs_to :goal
  belongs_to :account
end
