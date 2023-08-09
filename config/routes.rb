Rails.application.routes.draw do
  #resources :jobs
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'registrations'
      }
      #devise_for :users
      resources :jobs
      #devise_scope :user do
       # post "users/registration" => "registrations#create"
      #end   

      devise_scope :user do
        post "create_user" => "devise/registrations#create"
      end
      #post 'create_user' => 'devise/registrations#create', as: :create_user 
      namespace :users do
        resources :users
      end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "jobs#index"
end
