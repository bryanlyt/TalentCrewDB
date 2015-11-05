class ProjectsController < ApplicationController
  before_action :user_logged_in, only: [:create,:edit,:destroy]

  # show all projects by everyone 
  def index
    @projects = Project.all
  end

  # show all projects according to params[:id]
  def show 
    @project = Project.find_by(id: params[:id])
  end

  # create new project
  def new 
    @user = User.find_by(id: params[:id])
    @project = @user.projects.build
  end

  def create 
    user = User.find(params[:user_id])
    @project = user.projects.create(project_params)

    if @project.save
      flash[:success] = "New job / project listing created!"
      redirect_to root_url
    else
      render 'projects#new'
    end
  end

  # make changes to existing project
  def edit 
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to current_user
    else
      render 'projects#edit'
    end
  end

  # delete project
  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to current_user
  end

  private
    # check for the permitted input for security
    def project_params
      params.require(:project)
        .permit(:title, :description)
    end

end
