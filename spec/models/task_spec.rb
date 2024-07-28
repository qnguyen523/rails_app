# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    context 'when title is not present' do
      it 'is invalid' do
        task = Task.new(title: nil)
        task.valid?
        expect(task.errors[:title]).to include("can't be blank")
      end
    end
  end
end
