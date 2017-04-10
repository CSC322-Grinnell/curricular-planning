Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # See how all your routes lay out with "rake routes".
  get 'dashboard' => 'dashboard#get'
 post 'dashboard' => 'dashboard#post'

end
