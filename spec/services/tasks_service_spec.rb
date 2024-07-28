# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksService do
  let(:service) { described_class.new }
  let(:task) { Task.create(title: 'Title 1',
                           sub_title: 'Sub Title 1',
                           due_date: Date.today,
                           priority: 1,
                           completed: false) }
  let(:params) { { id: task.id, completed: true } }
  describe 'Update a task' do
    before do
      service.update(params)
    end
    it 'Success' do
      expect(task.reload).to have_attributes(completed: true)
    end
  end
end
