class Task < ApplicationRecord
  belongs_to :project
  validates :name,presence: true
  validates :description,presence: true
  validates :startdate,presence: true
  validates :enddate,presence: true

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
	
