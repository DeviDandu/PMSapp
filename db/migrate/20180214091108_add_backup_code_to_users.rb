class AddBackupCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :backup_code, :string
  end
end
