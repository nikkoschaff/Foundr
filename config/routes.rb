Foundr::Application.routes.draw do
    get 'roles/login' => 'roles#login'
    get 'roles/signup' => 'roles#signup'
    post 'roles/authenticate' => 'roles#authenticate'
    post 'roles/logout' => 'roles#logout'
    resources :roles
end
