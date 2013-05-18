class AttachmentsController < ApplicationController

  before_filter :confirm_enabled
  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attachments }
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.json
  def new
    @attachment = Attachment.new
    @task = Task.find(params[:task])
    @attachment.task_id = @task.id
    @pagetitle = "Add attachment to task #{@task.name}"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
    @task = @attachment.task
    @pagetitle = "Edit attachment to task #{@task.name}"
    @edit = true
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(params[:attachment])

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to task_path(@attachment.task), notice: 'Attachment was successfully created.' }
        format.json { render json: @attachment, status: :created, location: @attachment }
      else
        format.html { render action: "new" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.json
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to task_path(@attachment.task), notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @task = @attachment.task
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to task_path(@attachment.task), notice: 'Attachment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
