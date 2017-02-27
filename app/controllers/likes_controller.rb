class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :load_project, only: [:create, :destroy]

  def create

    @like = @project.likes.build user_id: current_user.id
    if @like.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @like = @project.likes.find_by user_id: current_user.id
    if @like.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def load_project
    @project = Project.find_by id: params[:project_id]
    render file: Settings.page_404_url unless @project
  end
end
