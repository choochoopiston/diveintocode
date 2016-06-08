class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :content,  
  presence: { message: "入力してください。" }
  
end