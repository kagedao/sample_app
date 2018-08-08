Rails.application.routes.draw do
  #get 'users/show'

  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  #2018/07/19,using "show" action,suzuki
  resources :users, only: [:show, :index, :destroy]
  root 'static_pages#home'

  match '/help',    to: 'static_pages#help',    via: 'get'
  
  match '/about',   to: 'static_pages#about',   via: 'get'
  
  match '/contact', to: 'static_pages#contact', via: 'get'
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
