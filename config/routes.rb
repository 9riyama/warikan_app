Rails.application.routes.draw do
  
  root 'home#top' 
  get '/:about', to: 'home#about'
  
  
  resources :users, only: [:edit, :create, :new, :show, :update] do
    collection do
      post:login
      post:logout
      get:login_form
    end

    member do
      get:partner_pay
    end
  end

  resources :posts, only: [:new, :show, :destroy, :edit, :create, :update] 
  
  get 'posts/month/:id/:pay_month', to: 'posts#monthly_total'
  get 'posts/month_index/:id', to: 'posts#month_index'
  get 'posts/index/:id', to: 'posts#index'

end