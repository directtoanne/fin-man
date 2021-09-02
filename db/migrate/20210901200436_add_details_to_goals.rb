class AddDetailsToGoals < ActiveRecord::Migration[6.0]
  def change
    change_column_default :goals, :current_amount, from: nil, to: 0
  end
end
