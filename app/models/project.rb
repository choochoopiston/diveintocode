class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :teams, dependent: :destroy
  
  def mates(user)
    teams.find_by(mate_id: user.id)
  end
  
end