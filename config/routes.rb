Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".

  devise_for :users
  
  get 'dashboard' => 'dashboard#get'
 post 'dashboard' => 'dashboard#post'
  
end
