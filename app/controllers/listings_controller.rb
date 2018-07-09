class ListingsController < ApplicationController

	def index
		# @listings = Listing.all // OLD CODE
		@listings = Listing.paginate(:page => params[:page], :per_page => 5)
	    #HOW TO MAKE TEH NEXT PAGE SHOW UP!
	end

    def show
    	@listing = Listing.find(params[:id])
    end

    def new
    	@user = current_user
    	# @listing = Listing.new
    end

    def create
    	@listing = Listing.new(listing_params)
    	@listing.user_id = current_user.id

       if @listing.save
		  redirect_to @listing
	   else
		  render 'new'
       end
	end
	
	#THIS IS THE PRIVATE METHOD, THAT ALLOWS US TO VERIF FIELDS SO HACKERS CAN EMULATE OUR FORMS AND PASS IN CORRUPTIVE DATA
	private
	def listing_params
		params.require(:listings).permit(:property_name, :property_description, :max_guest_number, :country, :city, :price) 
	end
end
