class CreateVitals < ActiveRecord::Migration[7.1]
  def change
    create_table :vitals do |t|
      t.integer :weight
      t.string :name

      t.timestamps
    end
  end
end
