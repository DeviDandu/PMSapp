class AddCreditsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :credits, :integer
  end
end
