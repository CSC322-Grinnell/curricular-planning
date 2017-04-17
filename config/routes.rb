Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "devise/my_devise/registrations" }
  # See how all your routes lay out with "rake routes".
  get 'dashboard' => 'dashboard#get'
 post 'dashboard' => 'dashboard#post'

end
