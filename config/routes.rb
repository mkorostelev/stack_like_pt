Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create, :index, :show]
    resource :me, controller: 'users', only: [:show, :update]

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
    resources :users, only: [:create, :index, :show, :update]

    resource :me, controller: 'users', only: [:show, :update]

    resources :posts, only: [:index, :show, :destroy]
  end
end
