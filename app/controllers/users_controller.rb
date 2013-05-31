class UsersController < ApplicationController
  before_filter :confirm_enabled
  before_filter :confirm_admin, :only => [:enable, :disable, :staff, :destaff, :destroy]

  # GET /users
  # GET /users.json
  def index
    if params[:staff] && params[:staff] == "true"
      @pagetitle = "Staff Users List"
      @users = User.staff
    else
      @pagetitle = "Regular Users List"
      @users = User.nonstaff
    end

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if params[:archived] && params[:archived] == "true"
      if current_user.staff?    
        @pagetitle = "Archived tasks for user #{@user.name}"
        @tasks = @user.tasks.inactive.order('updated_at DESC')
      else
        @pagetitle = "Archived tasks created by user #{@user.name}"
        @tasks = Task.where(:author_id => @user.id).inactive.order('updated_at DESC')
      end
    else
      if current_user.staff?
        @pagetitle = "Active tasks for user #{@user.name}"
        @tasks = @user.tasks.active.roots.order('created_at DESC')
      else
        @pagetitle = "Active tasks created by user #{@user.name}"
        @tasks = Task.where(:author_id => @user.id).roots.order('created_at DESC')
      end
    end

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def enable
    @user = User.find(params[:id])
    @user.enabled = true
    @user.save
    UserMailer.enabled_email(@user).deliver
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def disable
    @user = User.find(params[:id])
    @user.enabled = false
    @user.save
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def staff
    @user = User.find(params[:id])
    @user.staff = true
    @user.save    
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def destaff
    @user = User.find(params[:id])
    @user.staff = false
    @user.save    
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
