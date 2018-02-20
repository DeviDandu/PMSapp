class AddOtpSecretKeyToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :otp_secret_key, :string
  end
end
