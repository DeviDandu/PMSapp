class Project < ApplicationRecord
	has_many :tasks, :dependent => :destroy
	belongs_to :user
	has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments
end
