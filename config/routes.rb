Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :users, only: [:create]
  # resource :logins, only: [:create] do
  #   resources :employees , only: [:index, :show, :create, :update, :destroy] do
  #     resources :expenses,  only: [:index, :show, :create, :update, :destroy] do
  #       resources :comments, only: [:create]
  #       post 'comments/:id/reply', to: 'comments#reply', on: :member
  #       resources :expensesreport, only: [:show]
  #     end
  #   end
  # end  

  resources :users, only: [:create]
  resource :logins, only: [:create] do
    resources :employees , only: [:index, :show, :create, :update, :destroy] do
      resources :expenses,  only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:create]
        post 'comments/:id/reply', to: 'comments#reply', on: :member
        resources :expensesreport, only: [:show]

     
      put 'approve', to: 'expenses#approve', on: :member
      put 'reject', to: 'expenses#reject', on: :member
    end
  end
end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
