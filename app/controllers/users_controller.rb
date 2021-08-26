class UsersController < ApplicationController
  def dashboard
    @accounts = current_user.accounts
    @goals = current_user.goals
    # authorize @accounts - one is enough, since it authorises the (current) user (in this case, which is not the way to do that)
    authorize @goals
  end
end
