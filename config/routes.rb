Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create, :destroy, :index, :update] do
      get 'me', on: :collection
      #!!! resource :me, only: :show, on: :collection
    end

    resource :session, only: [:create, :destroy]

    resources :categories, only: [:index, :show] do
      resources :posts, only: [:index, :create]
    end

    resources :posts, only: [:index, :show] do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: :create
    end

    resources :comments, only: :index do
      resource :likes, only: [:create, :destroy]
    end
  end

  namespace :admin do

  end
end
