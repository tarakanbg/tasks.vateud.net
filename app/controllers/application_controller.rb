class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def confirm_enabled
    unless current_user.enabled?
      flash[:error] = "Insufficient privileges! Account not enabled, contact VATEUD7!"
      redirect_to "/forbidden"
    end
  end

  def confirm_staff
    unless current_user.staff?
      flash[:error] = "Insufficient privileges! Action available for staff members only!"
      redirect_to "/forbidden"
    end
  end

  def confirm_admin
    unless current_user.admin?
      flash[:error] = "Insufficient privileges! Action available for administrator members only!"
      redirect_to "/forbidden"
    end
  end
end
