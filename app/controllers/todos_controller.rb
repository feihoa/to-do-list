class TodosController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create  

        projectExists =  Project.exists?(:title => pr_params[:title])

        if !projectExists
            project = Project.new(:title => pr_params[:title])
            if project.save
                project = find_project(project.id)
            else
                render json: {errors: project.errors}, status: :unprocessable_entity
            end
        else
            project = find_project_by_title( pr_params[:title])

        end

        task = project[0].tasks.new(pr_params[:task][0])
        if task.save
            task = find_task(task.id)
            project = {
                'id' => project[0].id,
                'title' => project[0].title,
                'task' => task
              }

            render json: project, status: 201
        else
            render json: {errors: task.errors}, status: :unprocessable_entity
        end
    end

    private
    def pr_params
        params.require(:project).permit(:title, task:[:text, :"isCompleted"])
    end

    def find_project id
        Project.select(:id, :title).where(id: id)
    end
    def find_project_by_title title
        Project.select(:id, :title,).where(title: title)
    end
    def find_task id
        Task.select(:id, :text, :"isCompleted").where(id: id)
    end
end
