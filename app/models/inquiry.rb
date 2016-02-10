class Inquiry < ActiveRecord::Base
  
  validates :name,  
  presence: { message: "の入力は必須です。" },
  length: { minimum: 15, message: "は3文字以上15文字以内で入力ください。" } 
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
  presence: { message: "の入力は必須です。" },
  length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX, message: "が有効なメールアドレスかご確認ください。"}
    
end
