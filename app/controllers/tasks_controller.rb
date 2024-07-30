# frozen_string_literal: true

class TasksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_service
  def new
    @task = Task.new
  end

  def create
    task = @service.create(create_params)
    errors = task.errors.full_messages
    if errors.any?
      flash[:error] = errors.join('<br>')
      @task = task
      render 'new'
    else
      flash[:success] = 'Task created successfully'
      @tasks = Task.not_completed.order(:id)
      render 'index'
    end
  end

  def index
    @tasks = @service.index
    render 'index'
  end

  def list
    @tasks = @service.list
    render 'list'
  end

  def destroy
    id = params.permit(:id)[:id]
    task = Task.find(id)
    task.destroy
    flash[:success] = 'Task deleted successfully' if task.destroyed?
    @list_all = true
    @tasks = Task.not_completed.order(:id)
    respond_to do |format|
      format.js { render 'destroy' }
      format.html { render 'list' }
    end
  end

  def show
    @task = @service.show(params.permit(:id)[:id])
  end

  def edit; end

  def update
    @service.update(update_params)
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

  def set_service
    @service = TasksService.new
  end
end
