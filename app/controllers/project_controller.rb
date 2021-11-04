class ProjectController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        @projects = Project.all()
        @tasks = Task.all()

        projects_json = []
        @projects.each_with_index do |project, index|
            projects_json << {
                "id" => project.id,
                "title" => project.title,
                "todos" => []
                
            }
            @tasks.each do |task|
            if task.project_id == project.id
                projects_json[index]["todos"] << {
                    "id" => task.id, 
                    "text" => task.text, 
                    "isCompleted" => task.isCompleted
                }
              end
            end
          end
        render json: projects_json, status: :ok
    end

    def update
        task = Task.find(params[:id])

        if task.update({isCompleted:!task_params[:isCompleted]})
            task = find_task(params[:id])
            render json: task, status: :ok
        else
            render json: {errors: tasks.errors}, status: :unprocessable_entity
        end 
    end
    private
    def task_params
        params.require(:task).permit(:id, :text, :"isCompleted")
    end

    def find_task id
        Task.select(:id, :text, :"isCompleted").where(id: id)
    end
end
