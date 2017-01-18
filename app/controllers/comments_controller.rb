class CommentsController < ApplicationController
  before_action :load_project, only: :create

  def create
    @comment = @current_project.comments.build comment_params
      if @comment.save
        respond_to do |format|
        format.html {redirect_to @comment}
        format.js {}
      end
    else
    render root_path
    end
  end
  end

  private

  def comment_params
    params.permit :name, :content
  end

  def load_project
    @current_project = Project.find_by id: params[:id]
    return render file: Settings.page_404_url unless @current_project
  end
end
