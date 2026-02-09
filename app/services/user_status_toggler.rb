# app/services/user_status_toggler.rb
class UserStatusToggler
  def initialize(user, requested_status)
    @user = user
    @requested_status = requested_status
  end

  def call
    # 1. Logic: Check if the status is actually different
    return true if @user.status == @requested_status

    # 2. Logic: Perform the update
    if @user.update(status: @requested_status)
      log_the_change
      return true
    end

    false
  end

  private

  def log_the_change
    # Instead of a mailer, we interact with the System Rails Logger
    Rails.logger.info "--------------------------------------------------"
    Rails.logger.info "AUDIT LOG: User #{@user.unique_id} changed to #{@requested_status}"
    Rails.logger.info "TIMESTAMP: #{Time.current}"
    Rails.logger.info "--------------------------------------------------"
  end
end