class ListingsController < ApplicationController
    before_action :require_login, :only => [:new, :create, :edit, :update]

	def index
		
        @listings = Listing.paginate(:page => params[:page], :per_page => 5)
        @amenities = [ "Free Bananas Provided", "Washing Machine", "Balcony", "Toiletries", "Tea & Coffee", "Hairdryer", "Wifi", "Laptop Friendly Workspace", "Hot Tub", "Sauna", "Swimming Pool"]
        
    end

    def filter
        @listings = Listing.max_guest_scope(params[:filter][:guest_number]).city_scope(params[:filter][:city]).price_range_scope(params[:filter][:min_price], params[:filter][:max_price]).paginate(:page => params[:page], :per_page => 5)
        @filtered = true
        @city = params[:filter][:city]
        @guests = params[:filter][:guest_number]
        @min_price = params[:filter][:min_price]
        @max_price = params[:filter][:max_price]
        render 'index'
    end

    def show
    	@listing = Listing.find(params[:id])
    end

    def new
    	@user = current_user
    	@amenities = [ "Free Bananas Provided", "Washing Machine", "Balcony", "Toiletries", "Tea & Coffee", "Hairdryer", "Wifi", "Laptop Friendly Workspace", "Hot Tub", "Sauna", "Swimming Pool"]
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

        # here I clear the amenities array so that the newly selcted amenities can be places inside.
		@listing.amenities.clear
		@listing.save
       
        @listing.update(update_params)
        redirect_to @listing
	end

	def edit
        @listing = Listing.find_by_id(params[:id])
        @amenities = [ "Free Bananas Provided", "Washing Machine", "Balcony", "Toiletries", "Tea & Coffee", "Hairdryer", "Wifi", "Laptop Friendly Workspace", "Hot Tub", "Sauna", "Swimming Pool"]
        @current_amenities = @listing.amenities


        @amenities.each do |amen|
        	if @current_amenities.include? amen
        	   @amenities.delete(amen)
        	else
        	end
       end	

       p @amenities

    end
	
	def destroy
		@listing = Listing.find_by_id(params[:id])
		@listing.destroy
		redirect_to "/listings/#{params[:id]}"
	end

#NOT WORKING!!!!
    def country_official
        country = self.country
        ISO3166::Country[country]
    end

	#THIS IS THE PRIVATE METHOD, THAT ALLOWS US TO VERIF FIELDS SO HACKERS CAN EMULATE OUR FORMS AND PASS IN CORRUPTIVE DATA
	private
	def listing_params
		params.require(:listings).permit(:property_name, :property_description, :max_guest_number, :country, :city, :price, {images: []}, {amenities: []}) 
	end
    
    #THIS DECLARES THE ITEMS THAT CAN BE 'UPDATED'. 
	def update_params
		params.require(:listings).permit(:property_description, :property_name, :max_guest_number, :price, {images: []}, {amenities: []})
	end


  def require_login
    unless signed_in?
      flash[:notice] = "Sign up or Login to access this feature"
      redirect_to sign_up_path # halts request cycle
    end
  end

end
