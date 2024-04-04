Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

 # Roomsのルーティング
resources :rooms, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
  # Searchアクションへのルーティング
  collection do
    get :search
  end

  # Reservationsのネストされたルーティング
  resources :reservations, only: [:new, :create, :index, :edit, :update] do
    # Confirmアクションへのカスタムルーティング
    collection do
      post :confirm
    end
  end
end


  # プロフィール編集ページと更新アクションのルーティング
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile

  # ログアウトエラー解決のためのルーティング
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
end
