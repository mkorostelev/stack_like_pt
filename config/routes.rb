Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create, :destroy, :index, :update]

    resource :session, only: [:create, :destroy]

    resource :me, only: :show

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
