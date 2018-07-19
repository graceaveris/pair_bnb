Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  root "welcome#index"


  #AUTH ROUTES // DONT TOUCH
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  #SESSIONS ROUTES
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  #USERS ROUTES
  get "/users/:id" => "users#show", as: "user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  #LISTINGS ROUTES
  
  put "listings/:id" => "listings#update" #This updates the listing based on the id param

  delete "/listings/:id/destroy" => "listings#destroy", as: "destroy_listing"

  get "/listings" => "listings#index" #This show an index of current listings
  get "/listings/new" => "listings#new" #This serves the form for a new listing
  get "/listings/:id" => "listings#show", as: "listing" #This shows a listing based on id param

  post "/listings" => "listings#create" #This creates the listing upon submit of form

  get "/listings/:id/edit" => "listings#edit", as: "edit_listing" #This serves the edit form for a listing
  
  post "/listings/filter" => "listings#filter", as: "filter_listings"#serves index view via filter def


#RESERVATIONS ROUTES
  
  resources :listings do
  resources :reservations, only: [:index, :create, :new]
end

  get "/reservations/:id" => "reservations#show", as: "reservation" #This shows a reservation based on id param

  get "/reservations/:id/edit" => "reservations#edit", as: "edit_reservation" #This serves the edit form for a reservation

   
  delete "/reservations/:id/destroy" => "reservations#destroy", as: "destroy_reservation"


#above gives us the following routes to use:
# listing_reservations GET    /listings/:listing_id/reservations(.:format)     reservations#index
#                       POST   /listings/:listing_id/reservations(.:format)     reservations#create
# new_listing_reservation GET    /listings/:listing_id/reservations/new(.:format)     reservations#new

#PAYMENTS ROUTES

  # get 'payments/:id/new' => "payments#new", as: "new_payment"
  get '/reservations/:id/payments/new' => "payments#new", as: "new_payment"

  # post 'payments/checkout'
  post '/reservations/:id/payments/checkout' => "payments#checkout", as: "checkout"
end








