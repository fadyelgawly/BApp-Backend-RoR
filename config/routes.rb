Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resource :users, only: [:create]
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"
      resources :posts do
        resources :comments, :tags
      end
    end
  end
end
