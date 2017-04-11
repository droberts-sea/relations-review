class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :instructor
      t.integer :cohort
      t.date :start_date

      t.timestamps
    end
  end
end
