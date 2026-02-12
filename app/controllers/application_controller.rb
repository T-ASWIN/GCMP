class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  include Pagy::Method

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :unique_id, :branch_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :unique_id, :branch_id])
  end

  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end
  def after_sign_in_path_for(resource)
    # This redirects to the 'index' action of the UsersController
    if resource.admin?
      admin_root_path
    else
      user_root_path
    end  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(appointment_slots_path)
  end
end
