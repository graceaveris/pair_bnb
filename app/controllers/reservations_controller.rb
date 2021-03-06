
class ReservationsController < ApplicationController

    def new
    	@listing = Listing.find(params[:listing_id])
    end

  
    def create  	   

        @reservation = Reservation.new(reservation_params)
    	  @reservation.user_id = current_user.id
      	@reservation.listing_id = (params[:listing_id])
    	  @listing = Listing.find(params[:listing_id])
        
  

        if @reservation.save
#THE METHOD BELOW DELETES THE RESERVATION AFTER TEN MINUTES IF IT IS NOT PAID
          DeleteUnpaidBookingJob.set(wait: 10.minutes).perform_later(@reservation)
  	  	  redirect_to "/reservations/#{@reservation.id}/payments/new"
  	     else
          flash[:notice] = "Not available on those dates"
    		  render 'new'
        end

     end

     def show
  	   @reservation = Reservation.find(params[:id])
    end


    	
	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to "/users/#{current_user.id}"
	end


	private
	def reservation_params
		params.require(:reservations).permit(:start_date, :end_date) 
	end
    
    #THIS DECLARES THE ITEMS THAT CAN BE 'UPDATED'. 
	# def update_params
	# 	TBC
	# end

end


