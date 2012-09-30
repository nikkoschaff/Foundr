Foundr::Application.routes.draw do
  resources :profiles
  resources :ambitions
  resources :roles do
    resources :profiles
  end

    root :to => 'roles#login'

    get 'roles/login' => 'roles#login'
    get 'roles/signup' => 'roles#signup'
    post 'roles/signup' => 'roles#signup'
    post 'roles/authenticate' => 'roles#authenticate'
    post 'roles/logout' => 'roles#logout'
    get 'roles/show' => 'roles#show'
    get 'roles/search' => 'roles#search'
    resources :roles
    get 'tags/:tag', to: 'roles#index', as: :tag

end
