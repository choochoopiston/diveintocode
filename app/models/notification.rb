class Notification < ActiveRecord::Base
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::DateHelper
    
    belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
    belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
    belongs_to :comment, foreign_key: :comment_id, class_name: 'Comment'
    belongs_to :submit_request, foreign_key: :submit_request_id, class_name: 'SubmitRequest'
    
    scope :read, -> { where(read: true) }
    scope :unread, -> { where(read: nil) }
    scope :unread_count , -> (user_id) { where(recipient_id: user_id).unread.count }
    
    def self.sending_pusher(channel_user_id)
        Pusher.trigger("midoku#{channel_user_id}", 'message', { 
            unread_count: Notification.unread_count(channel_user_id)
        })
    end

    def message_time
        created_at.strftime("%m/%d/%y at %l:%M %p")
     end
    
end
