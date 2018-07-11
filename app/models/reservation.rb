class Reservation < ApplicationRecord
	
	belongs_to :user
	belongs_to :listing
	validate :overlaps?
    
    #this isolates the other bookings for the same property
  
     def overlaps?
     	
        current_bookings = Reservation.where(listing_id: self.listing_id)
     	current_bookings.each do |x|    
           return errors.add(:overlap, "overlapping dates detected") if self.start_date <= x.end_date && x.start_date <= self.end_date
        end
        return true
     end
end