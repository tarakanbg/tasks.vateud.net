class CommentsController < ApplicationController
  before_filter :confirm_enabled
  # before_filter :confirm_admin, :only => [:enable, :disable, :staff, :destaff, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.order('created_at DESC')
    @comments = @comments.paginate(:page => params[:page], :per_page => 20)
    @pagetitle = "Latest comments"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end
  end

  # POST /comments
  # POST /comments.json
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
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to task_path(@comment.task), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])

    unless @comment.user == current_user
      flash[:error] = "Insufficient privileges! This action is not available to you!"
      return redirect_to "/forbidden"
    end

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
