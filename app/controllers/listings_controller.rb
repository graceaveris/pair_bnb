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

	def update
		@listing = Listing.find(params[:id])
        @listing.update(update_params)
        redirect_to @listing
	end

	def edit
        @listing = Listing.find_by_id(params[:id])
        
    end
	
	def destroy
		@listing = Listing.find_by_id(params[:id])
		@listing.destroy
		redirect_to "/listings/#{params[:id]}"
	end



	#THIS IS THE PRIVATE METHOD, THAT ALLOWS US TO VERIF FIELDS SO HACKERS CAN EMULATE OUR FORMS AND PASS IN CORRUPTIVE DATA
	private
	def listing_params
		params.require(:listings).permit(:property_name, :property_description, :max_guest_number, :country, :city, :price, {images: []}) 
	end
    
    #THIS DECLARES THE ITEMS THAT CAN BE 'UPDATED'. 
	def update_params
		params.require(:listings).permit(:property_description, :property_name, :max_guest_number, :price, {images: []})
	end
end

