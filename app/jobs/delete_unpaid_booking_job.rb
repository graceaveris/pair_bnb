class DeleteUnpaidBookingJob < ApplicationJob
queue_as :default

  def perform(reservation)
    if reservation.payment_status == false
       reservation.destroy
    end
  end
end
