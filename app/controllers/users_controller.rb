class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only:[:edit, :update, :update_status]
  skip_before_action :authenticate_user!, only: [:new, :create]
    def index
      authorize User
     @users = User.userData
    end

  def new
    @user = User.new
  end

  def create  
  result = Users::Create.run(
    user_attributes: user_params.to_h
  )
  
  if result.valid?
    sign_in(result.result)
    redirect_to root_path, notice: "Account created successfully!"
  else
    @user = result.result
    flash.now[:alert] = result.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end
end


  def edit
  end

  def update
   result = Users::Update.run(
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
 result= Users::Status.run(
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


  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to users_path, alert: "User not found"
    else
      authorize @user
    end  
  end

  def user_params
    params.require(:user).permit(:name, :email, :unique_id, :password, :password_confirmation, :role, :status, :branch_id)
  end

end
