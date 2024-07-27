# frozen_string_literal: true

class TasksController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @task = Task.new
  end

  def create
    new_attributes = {
      title: create_params[:title].presence,
      sub_title: create_params[:sub_title].presence,
      due_date: create_params[:due_date]&.to_datetime&.localtime&.end_of_day || Time.now.end_of_day,
      priority: create_params[:priority]
    }
    task = Task.new(new_attributes)
    if task.save
      flash[:success] = 'Task created successfully'
      @tasks = Task.not_completed.order(:id)
      render 'index'
    else
      flash[:error] = 'Error creating task'
      @task = task
      render 'new'
    end
  end

  def index
    @tasks = Task.not_completed.order(:id)
    render 'index'
  end

  def list
    @tasks = Task.all.order(:id)
    render 'list'
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit; end

  def update
    task = Task.find(update_params[:id])
    task.update(completed: update_params[:completed])
    @list_all = update_params[:list_all] == 'true'
    flash[:success] = 'Task updated successfully'
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
