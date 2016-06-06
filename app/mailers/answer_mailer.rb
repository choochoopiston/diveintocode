class AnswerMailer < ApplicationMailer
    
    default from: 'choochoopiston@gmail.com'
    
    def answer_email(answer,question)
        @name = question.user.name
        @content = answer.content
        mail(to: question.user.email, subject: "回答をいただきました。")
    end
    
end
