class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.boolean :completed, default: false, null: false
      t.string :title, null: false
      t.string :sub_title
      t.datetime :due_date
      t.integer :priority
      t.timestamps
    end
  end
end
