class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :mates, :through => :teams, :source => :mate
  
  validates :title, presence: true

end