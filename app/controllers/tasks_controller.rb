# frozen_string_literal: true

class TasksController < ApplicationController
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
    task = Task.find(params[:id])
    task.update(completed: params[:completed])
    @list_all = params[:list_all] == 'true'
    flash[:alert] = 'Task updated successfully'
    @tasks = @list_all ? Task.all.order(:id) : Task.not_completed.order(:id)
  end
end
