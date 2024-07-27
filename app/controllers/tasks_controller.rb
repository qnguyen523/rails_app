# frozen_string_literal: true

class TasksController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @task = Task.new
  end

  def create
    new_attributes = {
      title: create_params[:title],
      sub_title: create_params[:sub_title],
      due_date: create_params[:due_date]&.to_datetime&.localtime&.end_of_day,
      priority: create_params[:priority]
    }
    Task.create(new_attributes)
    redirect_to root_path
  end

  def index
    @tasks = Task.not_completed.order(:id)
    render 'tasks/index'
  end

  def list
    @tasks = Task.all.order(:id)
    render 'tasks/list'
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit; end

  def update
    task = Task.find(update_params[:id])
    task.update(completed: update_params[:completed])
    @list_all = update_params[:list_all] == 'true'
    flash[:alert] = 'Task updated successfully'
    @tasks = @list_all ? Task.all.order(:id) : Task.not_completed.order(:id)
  end

  private

  def create_params
    params.require(:task).permit(:title, :sub_title, :due_date, :priority, :completed)
  end

  def update_params
    params.permit(:id, :completed, :list_all)
  end
end
