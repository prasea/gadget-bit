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

end
