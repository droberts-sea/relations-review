class RenameClassroomsNameToDesignation < ActiveRecord::Migration[5.0]
  def change
    rename_column :classrooms, :name, :designation
  end
end
