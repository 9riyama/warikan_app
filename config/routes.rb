Rails.application.routes.draw do
  
  root 'home#top' 
  get '/:about', to: 'home#about'
  
  
  resources :users, only: [:edit, :create, :new, :show] do
    collection do
      post:login
      post:logout
      get:login_form
    end

    member do
      post:update
      get:partner_pay
    end
  end

  get "posts/month/:id/:pay_month" => "posts#monthly_total" 
  get "posts/month_index/:id" => "posts#month_index"
  get "posts/index/:id" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

end
