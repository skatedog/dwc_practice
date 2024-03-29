Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  get 'searches/search'
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get 'followers', to: 'relationships#followers'
      get 'following', to: 'relationships#following'
    end
  end
  resources :books, except: :new do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end
