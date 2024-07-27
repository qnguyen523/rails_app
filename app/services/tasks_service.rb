# frozen_string_literal: true

class TasksService
  def initialize(); end

  def create(params)
    new_attributes = {
      title: params[:title].presence,
      sub_title: params[:sub_title].presence,
      due_date: params[:due_date]&.to_datetime&.localtime&.end_of_day || Time.now.end_of_day,
      priority: params[:priority]
    }
    task = Task.new(new_attributes)
    task.save
    task
  end

  def list
    Task.all.order(:id)
  end

  def index
    Task.not_completed.order(:id)
  end

  def show(id)
    Task.find(id)
  end

  def update(params)
    task = Task.find(params[:id])
    task.update(completed: params[:completed])
  end
end
