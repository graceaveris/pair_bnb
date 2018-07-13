class UsersController < Clearance::UsersController
	#DO NOT TOUCH
  def create
		 @user = user_from_params

	    if @user.save
        
  #THIS SENDS THE WELCOME MAILER TO THE USER, AND DEFIES THE URL ADDRESS
        @url = "http://example.com/"
       
   #this line is the code that sends the email via background jobs. 
        UserMailer.welcome_email(@user).deliver_now

    # This is the code (below) that will trigger email in code-line. Unblank to switch back/   
   # WelcomeEmailJob.perform_later(@user)
	 

        sign_in @user
	      redirect_back_or url_after_create
	    else
	      render template: "users/new"
	    end
	end


#BELOW HERE PUT YOUR METHODS
  def show
    @user = User.find(params[:id])
    @listings = @user.listings
    
  end


#PRIVATE METHOD
	private

	def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    birthday = user_params.delete(:birthday)
    avatar = user_params.delete(:avatar)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.birthday = birthday
      user.avatar = avatar
    end
  end
end