class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only:[:edit, :update, :update_status]
    def index
      authorize User
     @users = User.userData
    end

  def new
    authorize User
    @user = User.new
  end

  def create  
  authorize User
  result = Users::UserCreate.run(
    user_attributes: user_params.to_h
  )
  
  if result.valid?
    redirect_to users_path, notice: "User successfully created!"
  else
    flash.now[:alert] = result.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end
end


  def edit
    authorize User
  end

  def update
    authorize User
   result = Users::UserUpdate.run(
    user: @user,
    user_attributes: user_params.to_h
  )

  if result.valid?
    redirect_to users_path, notice: "User successfully updated!"
  else
    @user =  result.result
    flash.now[:alert] = result.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end
end 



def update_status
  authorize User
 result= Users::StatusUpdate.run(
    user: @user, 
    status: params[:user][:status]
  )

  if result.valid?
    redirect_to users_path, notice: "Status updated."
  else
    flash.now[:alert] = result.errors.full_messages.to_sentence
    render :is_active, status: :unprocessable_entity
  end
end

# def update_status
#   @user=User.find(params[:id])
#  if@user.update(status: params[:user][:status])
#   redirect_to users_path, notice: "User status updated to #{@user.status}."
#  else
#   render :toggle, status: :unprocessable_entity
#  end
# end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, alert: "User not found" if @user.nil?
  end
  def user_params
    params.require(:user).permit(:name, :email, :unique_id, :password, :password_confirmation, :role, :status)
  end

end
