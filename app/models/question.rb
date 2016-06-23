class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  
  validates :title,  
  presence: { message: "件名を入力してください。" }
  
  validates :content,  
  presence: { message: "内容を入力してください。" }
  
end
