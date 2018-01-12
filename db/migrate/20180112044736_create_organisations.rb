class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :code
      t.string :location

      t.timestamps
    end
  end
end
