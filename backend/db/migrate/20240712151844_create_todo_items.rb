class CreateTodoItems < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_items do |t|
      t.string :name, null: false
      t.datetime :due

      t.timestamps
    end
  end
end
