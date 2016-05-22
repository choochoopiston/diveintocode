class UserMailer < ApplicationMailer
    default from: 'choochoopiston@gmail.com'
    
    def inquiry_thanks(user)
        @user = user
        mail(to: @user.email, subject: 'お問い合わせありがとうございました。')
    end
end
