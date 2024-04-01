Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  resources :rooms do
    resources :reservations, only: [:new, :create, :show]
  end

  # プロフィール編集ページと更新アクションのルーティング
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile

  # ログアウトエラー解決のために追記
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
