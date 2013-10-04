class TasksController < ApplicationController

  before_filter :confirm_enabled, :except => [:forbidden, :rss, :rss_completed, :rss_comments]
  before_filter :confirm_admin, :only => [:destroy]
  
  def index
    @user = current_user
    @filter = true
    @pagetitle = "VATEUD Active Tasks"
    @search = Task.search(params[:q])
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @user.staff? ? @tasks = @search.result(:distinct => true) : @tasks = @search.result(:distinct => true).public
    params[:commit] == "Search" ? @tasks = @tasks : @tasks = @tasks.roots
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html 
      format.json { render json: @tasks }
    end
  end

  def my
    @user = current_user
    @filter = true
    @my = true
    @user.staff? ? @pagetitle = "Tasks for user #{@user.name}" : @pagetitle = "Tasks created by user #{@user.name}"
    @user.staff? ? @search = @user.tasks.search(params[:q]) : @search = Task.where(:author_id => @user.id).search(params[:q])
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    params[:commit] == "Search" ? @tasks = @search.result(:distinct => true) : @tasks = @search.result(:distinct => true).roots
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 25)
    render "index"
  end

  def archived
    @user = current_user
    # @filter = true
    @archived = true
    @pagetitle = "VATEUD Archived Tasks"
    @search = Task.inactive.search(params[:q])
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @user.staff? ? @tasks = @search.result : @tasks = @search.result.public
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 25)
    render "index"
  end

  def show    
    @task = Task.find(params[:id])
    if @task.private? && @task.author != current_user && current_user.staff == false
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      return redirect_to "/forbidden"
    end
    @pagetitle = "Task details: #{@task.name}"
    @archived = true
    @comments = @task.comments.order('created_at ASC')
    @comment = Comment.new
    @comment.task_id = @task.id
    @comment.user_id = current_user.id
    @versions = @task.versions.reorder('created_at DESC')
    @task.comments.each {|c| @versions += c.versions.order('created_at DESC') }
    # @versions = @versions.order('created_at DESC')

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @task }
    end
  end

  def new
    @pagetitle = "New Task"
    @task = Task.new
    @task.author_id = current_user.id
    @task.status_id = 1
    @task.due_date = Date.today + 1.week
    @task.parent_id = params[:parent_id] if params[:parent_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def edit    
    @task = Task.find(params[:id])
    @pagetitle = "Edit Task: #{@task.name}"
    unless (@task.status_id > 1 && @task.users.include?(current_user)) or (@task.status_id == 1 &&  @task.author == current_user) or current_user.admin?
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      return redirect_to "/forbidden"
    end
  end

  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        informed = []        
        @task.users.each {|u| informed << u.id}
        @task.informed = informed    
        @task.save
        informed.delete(current_user.id)
        Task.send_notifications(@task, informed) if informed && informed.count > 0  

        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    unless (@task.status_id > 1 && @task.users.include?(current_user)) or (@task.status_id == 1 &&  @task.author == current_user) or current_user.admin?
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      return redirect_to "/forbidden"
    end

    respond_to do |format|
      if @task.update_attributes(params[:task])
        if params[:commit] == 'Upload attachment'
          format.html { redirect_to new_attachment_path(:task => @task.id) , notice: 'Task was successfully updated.' }
        else
          @task.informed ? informed = @task.informed : informed = []
          uninformed = []       
          @task.users.each {|u| uninformed << u.id unless informed.include?(u.id)}
          if informed.count > 0
            merged = informed.zip(uninformed).flatten.compact
          else
            merged = uninformed
          end
          @task.informed = merged 
          @task.save
          uninformed.delete(current_user.id)
          Task.send_notifications(@task, uninformed) if uninformed && uninformed.count > 0

          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def accept
    @task = Task.find(params[:id])

    unless (@task.status_id == 1 || @task.status_id == 6) && @task.users.include?(current_user)
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      return redirect_to "/forbidden"
    end
    
    @task.due_date = Date.today if @task.due_date.past?
    @task.status_id = 2
    @task.save
    email_author(@task)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def cancel
    @task = Task.find(params[:id])

    unless (@task.status_id > 1 && @task.status_id < 6 && @task.status_id != 4 && @task.users.include?(current_user)) or (@task.status_id == 1 && @task.author == current_user)
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      return redirect_to "/forbidden"
    end

    @task.due_date = Date.today if @task.due_date.past?
    @task.status_id = 6
    @task.save
    @task.descendants.each do |child|
      child.status_id = 6
      child.save
      email_author(child)
    end
    email_author(@task)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def progress
    @task = Task.find(params[:id])

    unless (@task.status_id == 2 || @task.status_id == 5) && @task.users.include?(current_user)
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    @task.due_date = Date.today if @task.due_date.past?
    @task.status_id = 3
    @task.save
    email_author(@task)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def halt
    @task = Task.find(params[:id])

    unless @task.status_id == 3 && @task.users.include?(current_user)
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    @task.due_date = Date.today if @task.due_date.past?
    @task.status_id = 5
    @task.save
    email_author(@task)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def complete
    @task = Task.find(params[:id])

    unless @task.status_id > 0 && @task.status_id != 6 && @task.status_id != 4 && @task.users.include?(current_user)
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    @task.due_date = Date.today if @task.due_date.past?
    @task.status_id = 4
    @task.save
    @task.descendants.each do |child|
      child.status_id = 4
      child.save
      email_author(child)
    end
    email_author(@task)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def forbidden
    @pagetitle = "Your account is pending approval"
    if current_user.enabled?
      redirect_to root_path
    end
  end

  def rss    
    @tasks = Task.public.order('created_at DESC').limit(20)
    respond_to do |format|
       format.rss { render :layout => false }
    end
  end

  def rss_completed    
    @tasks = Task.public.inactive.order('updated_at DESC').limit(20)
    respond_to do |format|
       format.rss { render :layout => false }
    end
  end

  def rss_comments
    @comments = Comment.rss
    respond_to do |format|
       format.rss { render :layout => false }
    end
  end
  
private  
 
  def email_author(task)
    unless task.users.include?(task.author)
      UserMailer.delay.author_status_email(task)
    end 
  end
end
