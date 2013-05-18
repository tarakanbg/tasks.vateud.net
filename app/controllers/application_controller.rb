class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def confirm_enabled
    unless current_user.enabled?
      flash[:error] = "Insufficient privileges! Account not enabled, contact VATEUD7!"
      redirect_to "/forbidden"
    end
  end
end
