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
      collection do
        get :confirm_new  # 確認画面を表示するためのGETリクエスト
        post :confirm_new # 確認画面からのフォーム送信を処理するためのPOSTリクエスト
        post :confirm     # Confirmアクションへのカスタムルーティング
        get :confirm  # 予約確認画面へのルーティング
      end
      member do
        get 'confirm_edit'  # confirm_editアクションへのGETリクエストに対応
        patch 'confirm_edit' # confirm_editアクションへのPATCHリクエストに対応（追加）
      end
    end
  end

  # プロフィール編集とユーザー詳細（マイページ）へのルーティング
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile
  get '/profile', to: 'users#show', as: :user_profile
  resources :users, only: [:show]

  # 予約の一覧ページへのルーティング
  get 'reservations', to: 'reservations#index', as: :user_reservations

  # ログアウトエラー解決のためのルーティング
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
end
