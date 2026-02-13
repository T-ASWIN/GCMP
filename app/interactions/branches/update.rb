class Branches::Update < ActiveInteraction::Base
    object :branch
    hash :branch_attributes, strip: false

    def execute
      branch.assign_attributes(branch_attributes)

      if branch.save
      else
        errors.merge!(branch.errors)
      end
      branch
    end
  end
