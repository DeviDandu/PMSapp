class Project < ApplicationRecord
	has_many :tasks, :dependent => :destroy
	belongs_to :user
	has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments

  validates :name,presence: true
  validates :code,presence: true
  validates :startdate,presence: true
  validates :enddate,presence: true
 
  after_update :check_for_status

  def check_for_status
    self.status=status
    if status == "Active"
     self.update_column(:credits , 5)
   else
    self.update_column(:credits , 0)
    end
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

