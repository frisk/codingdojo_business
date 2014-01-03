CodingdojoBusiness::Application.routes.draw do
  resources :locations

  resources :homes
  resources :staffs
  resources :positions

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'thankyou', to: 'homes#index', as: 'thankyou'
  get 'manage', to: 'manager#index', as: 'manage'

  root to: 'sessions#new'
  
  resources :users
  resources :sessions

  resources :questions

  # resources :bootcamps do |bootcamp|
  #   # get "#{bootcamp}/responses" => 'responses#index', as :responses
  #   # get "#{bootcamp}/feedback" => 'responses#new'
  #   resources :surveys
  #   resources :responses, shallow: true
  # end
  resources :surveys do |survey| 
    get "#{survey}/responses/all" => 'responses#all'
    resources :responses, shallow: true
  end

  resources :responses, shallow: true do
    resources :answers
  end

  resources :bootcamps do |bootcamp|
    resources :surveys do |survey|
      get "#{bootcamp}/#{survey}/feedbacks/new" => "bootcamps#new_feedback"
      post "#{bootcamp}/#{survey}/feedbacks" => "bootcamps#create_feedback"
      get "#{bootcamp}/#{survey}/responses/statistics" => 'responses#statistics'
      resources :responses, shallow: true
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
