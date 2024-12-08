# require 'sidekiq-scheduler'

# class ScheduleJob
#   include Sidekiq::Job

#   def perform
#     Order.all.each do |order|
#       NotificationMailer.order_status(order.id).deliver_later
#     end
#   end
# end