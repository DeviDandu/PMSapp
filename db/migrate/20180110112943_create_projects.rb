class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :code
      t.date :startdate
      t.date :enddate
      t.string :status

      t.timestamps
    end
  end
end
