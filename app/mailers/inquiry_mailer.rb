class InquiryMailer < ApplicationMailer
    default from: 'choochoopiston@gmail.com'
    
    def inquiry_email(inquiry)
        @name = inquiry.name
        @content = inquiry.content
        mail(to: inquiry.email, subject: "お問い合わせありがとうございました")
    end
end
