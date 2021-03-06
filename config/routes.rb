Domimvp::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "comments/create"
  get "faq" => "faq#index", as: :faq_index
  get "how-it-works" => "about#index", as: :about_index
  get "mission" => "mission#index", as: :mission_index
  post 'twilio/voice' => 'twilio#voice'

  
  resources :properties do
    resource :image, only: [:create]
    resources :rooms
  end

  resources :tenants
  resources :dashboard, only: [:index]

  resources :appointments do
      resources :comments
  end


  resources :listings do
    resources :appointments
  end
  
  resources :profiles

  resources :subletters

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", omniauth_callbacks: "users/omniauth_callbacks"}, skip: [:sessions, :registrations]
  get "homes/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homes#index'
  devise_scope :user do
    get    "login"   => "devise/sessions#new",         as: :new_user_session
    post   "login"   => "devise/sessions#create",      as: :user_session
    delete "signout" => "devise/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "devise/registrations#new",    as: :new_user_registration
    post   "signup"  => "devise/registrations#create", as: :user_registration
    put    "signup"  => "devise/registrations#update", as: :update_user_registration
    get    "account" => "devise/registrations#edit",   as: :edit_user_registration
  end

end
