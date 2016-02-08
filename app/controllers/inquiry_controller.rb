class InquiryController < ApplicationController
    
    def index
      @inquiry = Inquiry.new
    end
    
    def confirm
      @inquiry = Inquiry.new(inquiry_params)
    end
    
    def thanks
      @inquiry = Inquiry.new(inquiry_params)
      @inquiry.save(inquiry_params)
    end
    
  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :content)
    end
end
