Foundr::Application.routes.draw do
  root :to => 'roles#login'
  resources :roles  
  resources :profiles
  resources :ambitions
  resources :roles do
    resources :profiles
  end

    
  get 'roles/login' => 'roles#login'
  get 'roles/signup' => 'roles#signup'
  post 'roles/signup' => 'roles#signup'
  post 'roles/authenticate' => 'roles#authenticate'
  #get 'roles/show' => 'roles#show'
  post 'roles/logout' => 'roles#logout'
  get 'roles/search' => 'roles#search'
  get 'tags/:tag', to: 'roles#index', as: :tag

end
