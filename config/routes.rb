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
    resources :reservations, only: [:show, :create, :destroy, :edit, :update, :index, :new] do
      # Confirmアクションへのカスタムルーティング
      collection do
        post :confirm
      end
    end
  end

  # プロフィール編集ページと更新アクションのルーティング
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile
  get '/profile', to: 'users#show', as: :user_profile

   # ユーザー詳細（マイページ）へのルーティング
  resources :users, only: [:show]

  # 予約の一覧ページへのルーティング
  get 'reservations', to: 'reservations#index', as: :user_reservations

  # ログアウトエラー解決のためのルーティング
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
end
