Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # See how all your routes lay out with "rake routes".

  devise_scope :user do
    authenticated :user do
      root 'dashboard#get', as: :authenticated_root
      post 'dashboard' => 'dashboard#post'
    end

    unauthenticated do
      root :to => redirect("/users/sign_in")
    end
  end

end
