Rails.application.routes.draw do
  #resources :jobs
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
      #devise_for :users
      resources :jobs
      #devise_scope :user do
       # post "users/registration" => "registrations#create"
      #end   
      post 'postulations', to:"postulations#user_postulation", as:"user_postulation"
      get 'my_postulations',  to:"postulations#job_with_postulation", as: "my_postulations"

        # devise_scope :user do
        #   get '/login' => 'devise/sessions#new'
        #   get '/logout' => 'devise/sessions#destroy'
        # end

      scope '/admin' do
        resources :users, :controller => 'users'
      end
      #post 'create_user' => 'devise/registrations#create', as: :create_user 
      #namespace :users do
        #resources :users
      #end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "jobs#index"
end
