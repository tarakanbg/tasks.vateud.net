module TasksHelper
  
  def edit_button(size, task)    
    if (task.status_id > 1 && task.users.include?(current_user)) or (task.status_id == 1 && task.author == current_user) or current_user.admin?
      if size == "big"
        link_to raw('<i class="icon-edit icon-white"></i> Edit'), edit_task_path(task), :title => "Edit task", :class => "btn btn-primary"
      elsif size == "mini"
        link_to raw('<i class="icon-edit"></i>'), edit_task_path(task), :title => "Edit Task"  
      end  
    end
  end

  def edit_button_comment(size, comment)    
    if comment.user == current_user
      if size == "big"
        link_to raw('<i class="icon-edit icon-white"></i> Edit'), edit_comment_path(comment), :title => "Edit comment", :class => "btn btn-primary"
      elsif size == "mini"
        link_to raw('<i class="icon-edit"></i>'), edit_comment_path(comment), :title => "Edit comment"  
      end  
    end
  end

  def attachment_button(size, task)    
    if (task.status_id > 1 && task.status_id < 6 && task.status_id != 4 && task.users.include?(current_user)) or (task.status_id == 1 && task.author == current_user)
      if size == "big"
        link_to raw('<i class="icon-upload icon-white"></i> Upload attachment'), new_attachment_path(:task => task.id), :title => "Upload attachment", :class => "btn btn-primary"
      elsif size == "mini"  
      end  
    end
  end

  def accept_button(size, task)    
    if (task.status_id == 1 || task.status_id == 6) && task.users.include?(current_user)
      if size == "big"
        link_to raw('<i class="icon-thumbs-up icon-white"></i> Accept Task'), {:action => :accept, :id => task.id}, :method => :put, :title => "Accept task", :class => "btn btn-success"
      elsif size == "mini" 
        link_to raw('<i class="icon-thumbs-up"></i>'), {:controller => :tasks, :action => :accept, :id => task.id}, :method => :put, :title => "Accept Task" 
      end  
    end
  end

  def subtask_button(size, task)    
    if (task.status_id > 1 && task.status_id < 6 && task.status_id != 4 && task.users.include?(current_user)) or (task.status_id == 1 && task.author == current_user)
      if size == "big"
        link_to raw('<i class="icon-plus icon-white"></i> Create Subtask'), new_task_path(:parent_id => task.id), :title => "Create Subtask", :class => "btn btn-info"
      elsif size == "mini"
        link_to raw('<i class="icon-plus"></i>'), new_task_path(:parent_id => task.id), :title => "Create Subtask"  
      end  
    end
  end

  def progress_button(size, task)    
    if (task.status_id == 2 || task.status_id == 5) && task.users.include?(current_user)
      if size == "big"
        link_to raw('<i class="icon-forward icon-white"></i> Mark In Progress'), {:action => :progress, :id => task.id}, :method => :put, :title => "Mark In Progress", :class => "btn btn-success"
      elsif size == "mini" 
        link_to raw('<i class="icon-forward"></i>'), {:controller => :tasks, :action => :progress, :id => task.id}, :method => :put, :title => "Mark In Progress" 
      end  
    end
  end

  def halted_button(size, task)    
    if task.status_id == 3 && task.users.include?(current_user)
      if size == "big"
        link_to raw('<i class="icon-warning-sign icon-white"></i> Mark Halted'), {:action => :halt, :id => task.id}, :method => :put, :title => "Mark as Halted", :class => "btn btn-warning"
      elsif size == "mini" 
        link_to raw('<i class="icon-warning-sign"></i>'), {:controller => :tasks, :action => :halt, :id => task.id}, :method => :put, :title => "Mark as Halted" 
      end  
    end
  end

  def completed_button(size, task)    
    if task.status_id > 0 && task.status_id != 6 && task.status_id != 4 && task.users.include?(current_user)
      if size == "big"
        link_to raw('<i class="icon-ok icon-white"></i> Mark Completed'), {:action => :complete, :id => task.id}, :method => :put, :title => "Mark Completed", :class => "btn btn-success"
      elsif size == "mini" 
        link_to raw('<i class="icon-ok"></i>'), {:controller => :tasks, :action => :complete, :id => task.id}, :method => :put, :title => "Mark Completed" 
      end  
    end
  end

  def cancel_button(size, task)    
    if (task.status_id > 1 && task.status_id < 6 && task.status_id != 4 && task.users.include?(current_user)) or (task.status_id == 1 && task.author == current_user)
      if size == "big"
        link_to raw('<i class="icon-remove icon-white"></i> Mark Cancelled'), {:action => :cancel, :id => task.id}, :method => :put, :confirm => "Are you sure you want to cancel this task?", :title => "Cancel task", :class => "btn btn-danger"
      elsif size == "mini"
        link_to raw('<i class="icon-remove"></i>'), {:controller => :tasks, :action => :cancel, :id => task.id}, :method => :put, :confirm => "Are you sure you want to cancel this task?", :title => "Cancel Task"  
      end  
    end
  end

  def delete_button(size, task)    
    if current_user.admin?
      if size == "big"
        link_to raw('<i class="icon-trash icon-white"></i> Delete task!'), {:action => :destroy, :id => task.id}, :method => :delete, :confirm => "Are you sure you want to DELETE this task? This action is non-reversible and you may consider canceling the task instead!", :title => "Delete task", :class => "btn btn-danger"
      elsif size == "mini"
        link_to raw('<i class="icon-trash"></i>'), {:controller => :tasks, :action => :destroy, :id => task.id}, :method => :delete, :confirm => "Are you sure you want to DELETE this task? This action is non-reversible and you may consider canceling the task instead!", :title => "Delete Task"  
      end  
    end
  end

  def delete_button_comment(size, comment)    
    if comment.user == current_user
      if size == "big"
        link_to raw('<i class="icon-remove icon-white"></i> Delete comment'), {:controller => :comments, :action => :destroy, :id => comment.id}, :method => :delete, :confirm => "Are you sure you want to delete this comment?", :title => "Delete Comment", :class => "btn btn-danger"
      elsif size == "mini"
        link_to raw('<i class="icon-remove"></i>'), {:controller => :comments, :action => :destroy, :id => comment.id}, :method => :delete, :confirm => "Are you sure you want to delete this comment?", :title => "Delete Comment"   
      end  
    end
  end

  def due_date_label
    current_user.staff? ? "Due date" : "Proposed due date"
  end

  def private_icon(task)
    if task.private?
      link_to raw('<i class="icon-eye-open"></i>'), "#", :title => "This task is private (staff only)"  
    end
  end

  def trim_string(string, length)
    result = string[0..length]
    result += "..." if string.length > length 
    result   
  end

  def filter_button
    raw('<a href="#task-filter" role="button" class="btn btn-primary" data-toggle="modal"><i class="icon-search icon-white"></i> Filter tasks</a>')
  end

end
