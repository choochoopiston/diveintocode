class InquiryMailer < ApplicationMailer
    default from: 'choochoopiston@gmail.com'
    
    def inquiry_email(inquiry)
        @name = inquiry.name
        @content = inquiry.content
        mail(to: inquiry.email, subject: "お問い合わせありがとうございました")
    end
<<<<<<< HEAD
end
=======
end
>>>>>>> deccc4da04dab670391355a8a9349c6d7167786f
