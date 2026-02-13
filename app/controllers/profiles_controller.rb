class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
  @user = current_user
  authorize @user

  if @user.update(user_params)
    redirect_to profile_path, notice: "Profile updated successfully"
  else
    render :show
  end
end

  def user_params
  params.require(:user).permit(:email, :status, :branch_id)
end

end
