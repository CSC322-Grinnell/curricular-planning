Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".
  get 'dashboard' => 'dashboard#get'
 post 'dashboard' => 'dashboard#post'

end
