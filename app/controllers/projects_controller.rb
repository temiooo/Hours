class ProjectsController < ApplicationController
  def index
    @projects = Project.by_last_updated.paginate(page: params[:page], per_page: 7)
    @entry = Entry.new
    @activities = Entry.order("CREATED_AT DESC").limit(20)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path, notice: I18n.t(:project_created)
    else
      render action: "new"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
