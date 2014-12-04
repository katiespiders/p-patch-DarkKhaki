Rails.application.routes.draw do

  root  'pages#about'

######### SESSIONS ROUTES
  get     'sessions/new',     to: "sessions#new",     as: :new_session
  post    'sessions/new',     to: "sessions#create"
  delete  'sessions',         to: "sessions#destroy", as: :session

######### USERS ROUTES
  get     'users/new',        to: "users#new",        as: :users
  post    'users/new',        to: "users#create"
  get     'users/:id',        to: "users#show",       as: :user
  get     'users/:id/edit',   to: "users#edit",       as: :edit_user
  patch   'users/:id/',       to: "users#update"
  delete  'users/:id',        to: "users#destroy"
  get     '/admin',           to: 'users#admin',      as: :admin

######### SHARED ITEMS ROUTES
  get '/library',             to: 'shared_items#index',     as: :library
  post '/library',            to: 'shared_items#create'
  patch '/library',           to: 'shared_items#checkout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
