class UsersController < ApplicationController
  def dashboard
    @accounts = current_user.accounts
    @goals = current_user.goals
    authorize @accounts
    # authorize @goals
  end
end
