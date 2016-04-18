class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
  end

  def downgrade
    @user = current_user

    @user.downgrade
    flash[:notice] = "You now have standard access."
    @user.wikis.update!(:private, false)
    redirect_to profile_path
  end
end
