class ReservationNotifierJob < ApplicationJob
  queue_as :default

#this is called from the payments controller
  def perform(listing)
    UserMailer.property_reservation_email(listing).deliver_later
  end
end

# Notes about sidekiq / redis etc
#
# You do not need to configure redis, but you must have the server running!
# Sidekick needs to have the line added to 
# file: config/initializers/active_job.rb
# line: config.active_job.queue_adapter = :sidekiq
# this makes sure that sidekiq is used instead of the default actionjob