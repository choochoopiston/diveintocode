class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :teams, dependent: :destroy
end