class TasksController < ApplicationController

  before_filter :confirm_enabled, :except => [:forbidden]
  # GET /tasks
  # GET /tasks.json
  def index
    ord = get_order(params[:sort])
    if params[:my] && params[:my] == "true"
      @search = current_user.tasks.roots.order('created_at DESC')
      @pagetitle = "Tasks for user #{current_user.name}"
    else
      @search = Task.roots.order('created_at DESC')
      @pagetitle = "VATEUD Active Tasks"
    end
    if params[:archived] && params[:archived] == "true"
      @search = Task.inactive.order('updated_at DESC')
      @pagetitle = "VATEUD Archived Tasks"
    else
      @search = @search.active
    end
    @search = Task.search(params[:search]) if params[:search]
    @tasks = @search.paginate(:page => params[:page], :per_page => 20).order(ord)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @pagetitle = "Task details: #{@task.name}"

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
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

  # GET /tasks/1/edit
  def edit    
    @task = Task.find(params[:id])
    @pagetitle = "Edit Task: #{@task.name}"
  end

  # POST /tasks
  # POST /tasks.json
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

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        if params[:commit] == 'Upload attachment'
          format.html { redirect_to new_attachment_path(:task => @task.id) , notice: 'Task was successfully updated.' }
        else
          informed = @task.informed
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

  # DELETE /tasks/1
  # DELETE /tasks/1.json
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
    @task.status_id = 2
    @task.save
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def cancel
    @task = Task.find(params[:id])
    @task.status_id = 6
    @task.save
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def progress
    @task = Task.find(params[:id])
    @task.status_id = 3
    @task.save
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def halt
    @task = Task.find(params[:id])
    @task.status_id = 5
    @task.save
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def complete
    @task = Task.find(params[:id])
    @task.status_id = 4
    @task.save
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
private  

  def get_order(param)
    case param
      when "id" then "id DESC"
      when "name" then "name ASC"
      else
       "id DESC"
    end
  end
end
