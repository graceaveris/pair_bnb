class Reservation < ApplicationRecord
	
	belongs_to :user
	belongs_to :listing
	validate :overlaps?

    
  
     def overlaps?
     	#This condition doed the following / loops through current reservations to find overlaps
        #lets the condition pass if its someone booking through the payment gateway (remember, we create the booking once, and then save it again once the payment clears).
        #Even calling an upate action on an object will run validations! Here we let the object save if the reservation id is equal to the self.    

        current_bookings = Reservation.where("listing_id = :listing_id and id <> :id", { listing_id: self.listing_id, id: self.id })

        #here we take current bookings, and check for overlapping dates! If dates overlap then the customer cannot book, and will be asked to try other dates.
        #originally we didnt have the error getting logged, and the formula for some reson wasnt giving us 'false'. By adding the error it forced the false. Although in theory you shouldnt need the error...
     	current_bookings.each do |x|  
           return errors.add(:overlap, "overlapping dates detected") if self.start_date <= x.end_date && x.start_date <= self.end_date
        end
        return true
     end
end