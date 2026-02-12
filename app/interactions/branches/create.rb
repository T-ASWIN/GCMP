class Branches::Create < ActiveInteraction::Base
    hash :branch_attributes, strip:false

    def execute
    branch = Branch.new(branch_attributes)

    
    unless branch.save
      errors.merge!(branch.errors)
    end

    branch
  end

end