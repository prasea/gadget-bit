class ApplicationController < ActionController::Base
  helper_method :admin_user?
  
  def admin_user?
    current_user.is_a?(Admin) if current_user
  end

  protected
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path
    else
      root_path
    end
  end

  private
  def authenticate_admin!
    unless current_user.is_a?(Admin)
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end


end
