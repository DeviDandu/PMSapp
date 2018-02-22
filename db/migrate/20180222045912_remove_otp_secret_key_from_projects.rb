class RemoveOtpSecretKeyFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :otp_secret_key, :string
  end
end
