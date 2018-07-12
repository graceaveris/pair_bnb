class PaymentsController < ApplicationController
  

  def new
  	  @client_token = Braintree::ClientToken.generate
  	  @reservation = Reservation.find(params[:id])

 #PASSES THE PRICE INTO THE MAKE PAYMENT FORM
  	  @listing = @reservation.listing
  	  @price = @listing.price
  	  @total_price = @price * (@reservation.end_date - @reservation.start_date).to_i
  end
 
  def checkout
 #PASSES THE PRICE INTO THE CHECKOUT
	  @reservation = Reservation.find(params[:id])
	  @listing = @reservation.listing
	  @price = @listing.price
	  @total_price = @price * (@reservation.end_date - @reservation.start_date).to_i

 #RUNS THE PAYMENT / BELOW IS THE CODE COPIED, YOU CAN DELETE EVERYTHING ABOVE AND THE GATEWAY WILL STILL WORK
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => @total_price,
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	  )

	  if result.success?
	  	@reservation.update(:payment_status => true)
	    redirect_to reservation_path(params[:id])
	    flash[:notice] = "Transaction successful!"
	  else
	  	
	    redirect_to new_payment_path(params[:id])
	    flash[:notice] = "Transaction failed. Please try again."
	  end
  end
end
