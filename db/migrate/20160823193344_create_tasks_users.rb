class CreateTasksUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks_users do |t|

      t.integer :task_id
      t.integer :user_id      

      t.timestamps null: false

    end

		add_index :tasks_users, :task_id
    add_index :tasks_users, :user_id
    add_index :tasks_users, [:task_id, :user_id], unique: true

  end
end
