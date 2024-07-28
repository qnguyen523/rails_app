# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'POST #create' do
    render_views

    it 'returns a success response' do
      post(:create, params: { task: { title: 'Title 1' } })
      expect(response).to be_successful
      expect(flash[:success]).to eq('Task created successfully')
      expect(Task.last).to have_attributes(title: 'Title 1')
    end
  end

  describe 'PATCH #update' do
    render_views
    let(:task) { Task.create(title: 'Title 1',
                             sub_title: 'Sub Title 1',
                             due_date: Date.today,
                             priority: 1,
                             completed: false) }

    it 'returns a success response' do
      patch(:update, params: { id: task.id, completed: true }, xhr: true, format: :js)
      expect(response).to be_successful
      expect(flash[:success]).to eq('Task updated successfully')
      expect(task.reload).to have_attributes(completed: true)
    end
  end
end
