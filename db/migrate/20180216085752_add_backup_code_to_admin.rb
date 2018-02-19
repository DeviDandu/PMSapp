class AddBackupCodeToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :backup_code, :string
  end
end
