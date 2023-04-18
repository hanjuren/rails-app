Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api, defaults: { format: :json } do
    scope :v1 do
      get "/meta", to: "base#alive"

      # sign
      scope :auth do
        post "/sign_up", to: "authenticate#sign_up"
        post "/sign_in", to: "authenticate#sign_in"
        post "/kakao_login", to: "authenticate#kakao_login"
        get "/kakao-callback", to: "authenticate#kakao_callback"
      end
    end
  end
end
