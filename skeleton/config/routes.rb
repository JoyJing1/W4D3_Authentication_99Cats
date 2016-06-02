NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end
  resource :session, only: [:create, :new] do
    delete "logout", on: :member, to:'sessions#destroy'
  end

  resources :users, only: [:create, :new]

  get 'session', :to => 'sessions#new'
  get 'users', :to => 'users#new'

  root to: redirect("/cats")
end
