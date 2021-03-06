Rails.application.routes.draw do

  resources :messages
  devise_for :users, controllers: { registrations: "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :joiners, :sharers, :contracts

  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/home'
  get 'static_pages/usertype'
  get 'static_pages/joinerinfo'
  get 'static_pages/sharerinfo'

  post 'static_pages/home'

  get '/about', to: redirect('static_pages/about')
  get '/help', to: redirect('static_pages/help')
  get '/joiner', to: 'joiners#new'
  get '/sharer', to: 'sharers#new'
  get '/contract', to: 'contracts#new'

  devise_scope :user do
    match '/login' => "devise/sessions#new", :as => :login, :via => [:get, :post]
    match '/signup' => "devise/registrations#new", :as => :signup, :via => [:get, :post]
    match '/logout' => "devise/sessions#destroy", :as => :logout, :via => [:get, :post]
  end

end
