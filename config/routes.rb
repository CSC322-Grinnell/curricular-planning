Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # See how all your routes lay out with "rake routes".

  root 'home#index', as: :authenticated_root #homepage

  devise_scope :user do
      get 'dashboard' => 'dashboard#get'
      post 'dashboard' => 'dashboard#post'
  end
end 
