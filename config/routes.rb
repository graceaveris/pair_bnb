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
  
  delete "/listings/:id/destroy" => "listings#destroy", as: "destroy_listing"

  get "/listings" => "listings#index"
  get "/listings/new" => "listings#new"
  get "/listings/:id" => "listings#show", as: "listing"

  post "/listings" => "listings#create"

  get "/listings/:id/edit" => "listings#edit", as: "edit_listing"

  put "listings/:id" => "listings#update"

end