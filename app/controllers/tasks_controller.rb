class TasksController < ApplicationController

	before_filter :authenticate_user!
  before_filter :get_project
  before_filter :get_task, :except => [:index,:new,:create]
  before_filter :verify_access, :only => [:edit, :update,:destroy]

  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.build
  end

  def create
    @task = Task.new(params[:task])
    @task.project = @project
    if @task.save
      redirect_to project_path(@project), :notice => "Task created!"
    else
      render :new
    end
  end

  def edit
    @task.comments.build(:user => current_user)
  end

  def show
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to project_path(@project), :notice => "Task updated!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_path(@project), :notice => "Task destroyed!"
  end

	private
	def get_project
		@project = Project.find(params[:project_id])		
	end
  
  def get_task
    @task = Task.find(params[:id])
  end

  def verify_access
    redirect_to project_path(@project), :notice => "Access denied" unless @task.can_be_managed_by?(current_user)
  end
end
