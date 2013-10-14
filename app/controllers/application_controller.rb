class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => [:rss, :@rss_completed, :rss_comments, :help]
  before_filter :app_options

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

  def app_options
    @org = "VATEUD"
    @rss_new = "http://feeds.feedburner.com/VateudNewTasks"
    @rss_completed = "http://feeds.feedburner.com/VateudCompletedTasks"
    @rss_comments = "http://feeds.feedburner.com/VateudLatestComments"
    @logo_image = "vateud_png.png"
  end
end
