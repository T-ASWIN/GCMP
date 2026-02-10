class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit 'name' for sign up and account updates
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :unique_id, :role, :status])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirects to login page
  end
  
  def after_sign_in_path_for(resource)
    # This redirects to the 'index' action of the UsersController
    users_path 
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
