class UsersController < ApplicationController
  before_filter :confirm_enabled, :except => [:help]
  before_filter :confirm_admin, :only => [:enable, :disable, :staff, :destaff, :destroy]

  def index
    if params[:staff] && params[:staff] == "true"
      @pagetitle = "Staff Users List"
      @users = User.staff
    else
      @pagetitle = "Regular Users List"
      @users = User.nonstaff
    end

    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    @versions = Version.where(:whodunnit => @user.id.to_s, :item_type => ["Task", "User", "Attachment", "Comment"]).reorder('created_at DESC').limit(50)
    if params[:archived] && params[:archived] == "true"
      if @user.staff?
        if current_user.staff == false
          @pagetitle = "Archived tasks for user #{@user.name}"
          @tasks = @user.tasks.public.inactive.order('updated_at DESC')
        else
          @pagetitle = "Archived tasks for user #{@user.name}"
          @tasks = @user.tasks.inactive.order('updated_at DESC')
        end
      else
        if current_user.staff == false
          @pagetitle = "Archived tasks created by user #{@user.name}"
          @tasks = Task.where(:author_id => @user.id).public.inactive.order('updated_at DESC')
        else
          @pagetitle = "Archived tasks created by user #{@user.name}"
          @tasks = Task.where(:author_id => @user.id).inactive.order('updated_at DESC')
        end
      end
    else
      if @user.staff?
        if current_user.staff == false
          @pagetitle = "Active tasks for user #{@user.name}"
          @tasks = @user.tasks.public.active.roots.order('created_at DESC')
        else
          @pagetitle = "Active tasks for user #{@user.name}"
          @tasks = @user.tasks.active.roots.order('created_at DESC')
        end
      else
        if current_user.staff == false
          @pagetitle = "Active tasks created by user #{@user.name}"
          @tasks = Task.where(:author_id => @user.id).public.roots.order('created_at DESC')
        else
          @pagetitle = "Active tasks created by user #{@user.name}"
          @tasks = Task.where(:author_id => @user.id).roots.order('created_at DESC')
        end
      end
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def enable
    @user = User.find(params[:id])
    @user.enabled = true
    @user.save
    UserMailer.delay.enabled_email(@user.id)
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

  def help
    m = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @content = m.render(File.open(Rails.root + "README.md", 'r').read)
    # render :text => content
  end
end
