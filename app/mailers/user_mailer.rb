class UserMailer < ApplicationMailer

  default from: 'grace@pairbnb.com'
  layout 'mailer'
  
#THIS GETS SENT WHEN THE USER SIGNS UP
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to my Pair BNB! ')
  end

#THIS GETS SENT TO A USER IF SOMEONE BOOKS THEIR PROPERTY
  def property_reservation_email(listing)
    @lister = listing.user
    @url  = 'http://example.com/login'
    mail(to: @lister.email, subject: 'You have a new booking! ')
  end

end

