class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :name, :string, null: false, index: true, unique: true
  	add_column :users, :organisation, :string
  end
end
