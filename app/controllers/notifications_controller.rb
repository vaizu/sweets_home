class NotificationsController < ApplicationController
  def index
    @user = current_user
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to request.referrer
  end
end
