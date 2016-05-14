class InquiryController < ApplicationController
    
    def index
      if params[:BTI]
      @inquiry = Inquiry.new(inquiry_params)
      else 
      @inquiry = Inquiry.new
      end
    end
    
    def confirm
      @inquiry = Inquiry.new(inquiry_params)
      if @inquiry.valid?
      render 'confirm'
      else
      render 'index'
      end
    end

    def thanks
      @inquiry = Inquiry.create(inquiry_params)
      InquiryMailer.inquiry_email(@inquiry).deliver
      
    end
    
    
  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :content)
    end
end
