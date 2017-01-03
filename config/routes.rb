Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :show, :edit, :update, :destroy] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings, controller: "listings", except: [:index]
  end

  resources :reservations

  resources :tags, controller: "tags", only: [ :create ]

  get "/listings" => "listings#index", as: "listings"
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth", as: "facebook_sign_in"
  get "/users" => "users#index", as: "master"
  post "/checkout_form" => "reservations#checkout", as: "checkout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#show"
end
