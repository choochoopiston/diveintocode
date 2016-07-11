class NotificationsController < ApplicationController

  
  def index
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
    @notifications.update_all(read: true)
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
  end


end