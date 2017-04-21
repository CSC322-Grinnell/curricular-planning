Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # See how all your routes lay out with "rake routes".

 # root 'home#index'
  
  devise_scope :user do
  #  root to: 'home#index'
    
    authenticated :user do
       get '/dashboard' => 'dashboard#get'
       post '/dashboard' => 'dashboard#post'
    end
  
    unauthenticated :user do
      get '/dashboard' => 'devise/sessions#new'
      post '/dashboard' => 'dashboard#post' 
    end
  end 
end 

