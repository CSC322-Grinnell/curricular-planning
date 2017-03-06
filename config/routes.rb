Rails.application.routes.draw do
    
  devise_for :users
  root 'static_pages#root'
  #devise_for :users
  #devise_scope :user do
      #classes data  
     # authenticated :user do
    #root 'static_pages#root', as: :authenticated_root #homepage
  #end

end
