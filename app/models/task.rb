# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  sub_title  :string
#  due_date   :datetime
#  priority   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Task < ApplicationRecord
  scope :not_completed, -> { where(completed: false) }
  enum priority: {
    low_priority: 1,
    medium_priority: 2,
    high_priority: 3
  }
end
