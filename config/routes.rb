Rails.application.routes.draw do
  namespace :api do
    resource :users

    resource :session, only: [:create, :destroy]
  end

  namespace :admin do

  end
end
