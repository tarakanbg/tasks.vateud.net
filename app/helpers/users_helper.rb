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

  def history_attachment(version)       
    link_to "Attachment #{version.item_id}", task_path(Attachment.find(version.item_id).task)    
    rescue ActiveRecord::RecordNotFound
      "Attachment #{version.item_id}"
  end

  def history_user(version)       
    link_to "User #{version.item_id}", user_path(version.item_id)  
    rescue ActiveRecord::RecordNotFound
      "User #{version.item_id}"
  end

  def history_task(version)       
    link_to "Task #{version.item_id}", task_path(version.item_id)
    rescue ActiveRecord::RecordNotFound
      "Task #{version.item_id}"
  end

  def history_type(version)
    if version.item_type == "Task"
      history_task(version)
    elsif version.item_type == "User"
      history_user(version)
    elsif version.item_type == "Attachment"
      history_attachment(version)
    end
  end
  
end
