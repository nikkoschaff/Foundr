Foundr::Application.routes.draw do
  root :to => 'application#find_root_url'
  resources :roles do
    resources :profiles
    collection do
      get 'login'
      post 'login'
      post 'authenticate'
      get   'search'
      post  'search'
      get 'refresh'
      post 'refresh'
    end
  end
  resources :profiles
  resources :ambitions


  post 'roles/login' => 'roles#login'
  get 'roles/login' => 'roles#login'
  get 'roles/signup' => 'roles#signup'
  post 'roles/signup' => 'roles#signup'
  post 'roles/authenticate' => 'roles#authenticate'
  post 'roles/logout' => 'roles#logout'
  get 'roles/search' => 'roles#search'
  post 'roles/search' => 'roles#search'
  get 'tags/:tag', to: 'roles#index', as: :tag
end
