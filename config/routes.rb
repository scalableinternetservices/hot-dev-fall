Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/home'

  devise_scope :user do
    match '/login' => "devise/sessions#new", :as => :login, :via => [:get, :post]
    match '/signup' => "devise/registrations#new", :as => :signup, :via => [:get, :post]
  end

end
