class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :projects
         validates :email, uniqueness: true,presence: true
 
         validates :name,presence: true,length: {in: 4..10}
         validates :organisation,presence: true


end