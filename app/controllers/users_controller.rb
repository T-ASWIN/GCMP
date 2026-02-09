class UsersController < ApplicationController

    def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to users_path, notice: "User successfully updated!"
    else
        render :edit, status: :unprocessable_entity
  end
end

def show
  @user=User.find(params[:id])
end

def toggle
  @user = User.find(params[:id])
end

def update_status
  @user = User.find(params[:id])
  
  # We initialize and call our simple interactor
  service = UserStatusToggler.new(@user, params[:user][:status])

  if service.call
    redirect_to users_path, notice: "Status updated successfully."
  else
    render :toggle, status: :unprocessable_entity
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

  def user_params
    params.require(:user).permit(:name, :email, :unique_id, :password, :password_confirmation, :role, :status)
  end
end
