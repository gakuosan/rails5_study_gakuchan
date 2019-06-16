class AddUseIdToTasks < ActiveRecord::Migration[5.1]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end

end
