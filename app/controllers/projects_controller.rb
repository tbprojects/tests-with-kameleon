class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_project, :except => [:index,:new,:create]
  before_filter :verify_access, :only => [:edit, :update,:destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new(:active => true)
  end

  def create
    @project = Project.new(params[:project])
    @project.manager = current_user
    if @project.save
      redirect_to projects_path, :notice => "Project created!"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to projects_path, :notice => "Project updated!"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, :notice => "Project destroyed!"
  end

  private
  def get_project
    @project = Project.find(params[:id])
  end

  def verify_access
    redirect_to projects_path, :notice => "Access denied" unless @project.can_be_managed_by?(current_user)
  end
end
