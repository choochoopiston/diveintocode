class Team < ActiveRecord::Base
    belongs_to :mate, class_name: "User"
    belongs_to :project
end