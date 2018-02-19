class User < ApplicationRecord
	attr_accessor :gauth_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :google_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable

         has_many :projects,:dependent => :destroy
         validates :email, uniqueness: true,presence: true ,on: :create
 
         validates :name,presence: true,length: {in: 3..10},on: :create
         validates :organisation,presence: true

        after_update :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now if self.confirmed_at_changed?
  end
end