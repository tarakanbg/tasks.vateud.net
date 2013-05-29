module UsersHelper
  def active_inactive_switch
    if params[:archived] && params[:archived] == "true"
      link_to raw('<i class="icon-list icon-white"></i> Switch to active tasks'), user_path(@user), :title => "Switch to active", :class => "btn btn-primary"
    else
      link_to raw('<i class="icon-list icon-white"></i> Switch to archived tasks'), user_path(@user, :archived => "true"), :title => "Switch to inactive", :class => "btn btn-warning"
    end
  end

  def active_inactive_switch_my
    if params[:archived] && params[:archived] == "true"
      link_to raw('<i class="icon-list icon-white"></i> Switch to active tasks'), root_path(:my => "true"), :title => "Switch to active", :class => "btn btn-primary"
    else
      link_to raw('<i class="icon-list icon-white"></i> Switch to archived tasks'), user_path(@user, :archived => "true"), :title => "Switch to inactive", :class => "btn btn-warning"
    end
  end
end
