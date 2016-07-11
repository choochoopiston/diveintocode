Rails.application.routes.draw do
  

  
  get 'notifications/index'

  resources :conversations do
    resources :messages
  end
  
  namespace :project do
  get 'tasks/ungoodjob'
  end

  namespace :project do
  get 'tasks/goodjob'
  end

  resources :teams, only: [:create, :destroy]
  get 'teams/create'
  get 'teams/destroy'

  resources :projects do
    member do
    get :teammates, :team_index
   end
    namespace :project do
      resources :tasks
    end
  end

  namespace :taskline do
    resources :task_comments
    resources :tasks do
    post "ungoodjob"
    post "goodjob"
    end
  end
  
  resources :tasks
  
  
  get 'relationships/create'
  get 'relationships/destroy'

  root to: "top#index"
  
  resources :answers

  resources :questions do
    resources :answers
  end
  
  resources :comments

  resources :blogs do
    resources :comments
  end
  
  get 'about/company_overview'

  get 'users/index'
  get 'users/show'


  devise_for :users, controllers: {
    auth: "/auth/:provider/callback",
    sessions: "users/sessions",
    registrations: "users/registrations",

    omniauth_callbacks: "users/omniauth_callbacks"
}


  resources :users, only:[:index, :show] do
    resources :tasks
    resources :notifications, only: [:index]
    member do
      get :following, :followers
    end
    resources :submit_requests, shallow: true do
      member do
      get 'approve'
      get 'unapprove'
      get 'reject'
      end
      collection do
        get 'inbox'
      end
    end
  end

  
  as :user do
  get 'users', to: 'users#show'
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :relationships, only: [:create, :destroy]
  
  

  get 'inquiry', to: 'inquiry#index'
  post 'inquiry', to: 'inquiry#index'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'


  
  get 'about' => 'about#company_overview'
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  # get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  
end
