class CommentsController < ApplicationController
  before_filter :confirm_enabled
  # before_filter :confirm_admin, :only => [:enable, :disable, :staff, :destaff, :destroy]

  def index
    @comments = Comment.order('created_at DESC')
    @comments = @comments.paginate(:page => params[:page], :per_page => 20)
    @pagetitle = "Latest comments"

    respond_to do |format|
      format.html
    end
  end

  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @task = @comment.task

    if @task.private? && current_user.staff == false
      flash[:error] = "Insufficient privileges! This Action is not available to you!"
      redirect_to "/forbidden"
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @task, notice: 'Comment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to task_path(@comment.task), notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end
