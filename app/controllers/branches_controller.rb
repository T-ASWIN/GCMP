class BranchesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_branch, only: [:edit, :update, :update_status]

    def index
        @branches = Branch.includes(:users).ordered
    end

    def new
    @branch = Branch.new
    end

    def create
      result = Branches::Create.run(branch_attributes: branch_params.to_h)
     
      if result.valid?
       redirect_to branches_path, notice: 'Branch was successfully created.'
     else
      @branch = result.result
      flash.now[:alert] = result.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
     end
    end


    def update_status
  result = Branches::Status.run(
    branch: @branch, 
    status: params[:branch][:status]
  )

  if result.valid?
    redirect_to branches_path, notice: "Branch status updated to #{@branch.status.humanize}."
  else
    @branches = Branch.includes(:users).ordered
    @errors = result.errors.full_messages
    render :index, status: :unprocessable_entity
  end
end


    def edit
    end

   def update
    result = Branches::Update.run(
    branch: @branch,
    branch_attributes: branch_params.to_h
  )

  if result.valid?
    redirect_to branches_path, notice: 'Branch was successfully updated.'
  else
    @errors = result.errors.full_messages
    render :edit, status: :unprocessable_entity
  end
end


   private

   def set_branch
    @branch=Branch.find(params[:id])
   end

   def status_params
    params.require(:branch).permit(:status)
  end
  
   def branch_params
    params.require(:branch).permit(:name, :status, :location)
  end
end
