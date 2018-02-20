class Project < ApplicationRecord
  has_one_time_password
	has_many :tasks, :dependent => :destroy
	belongs_to :user
	has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments

  validates :name,presence: true
  validates :code,presence: true
  validates :startdate,presence: true
  validates :enddate,presence: true
 
  after_update :check_for_status
  before_create :check_for_otp
 

  def check_for_status
    self.status=status
    if status == "Active"
     self.update_column(:credits , 5)
   else
    self.update_column(:credits , 0)
    end
  end

  def check_for_otp
    otp=self.otp_code.to_s
    puts "-------code is --------#{otp}"
  end

   rails_admin do
   
      edit do 
        configure :status , :enum do
          enum do
            ['Active','InActive']
          end
          default_value 'InActive'
        end 
      end
    end
end

