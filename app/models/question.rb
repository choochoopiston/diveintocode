class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  
  validates :title,  
  presence: { message: "入力してください。" }
  
  validates :content,  
  presence: { message: "入力してください。" }
  
end
