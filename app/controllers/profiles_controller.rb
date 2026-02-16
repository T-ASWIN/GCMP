class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
  @user = current_user
  authorize @user

  result = Users::UpdateProfile.run(
    user: @user,
    user_attributes: user_params
  )

  if result.valid?
    redirect_to profile_path, notice: "Profile updated successfully"
  else
    @user = result.result
    render :show, status: :unprocessable_entity
  end
end

  def user_params
  params.require(:user).permit(:email, :status, :branch_id)
end

end
