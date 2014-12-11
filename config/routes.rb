require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server, at: '/resque'

  root  'articles#index'

######### SESSIONS ROUTES
  get     'sessions/new',     to: 'sessions#new',     as: :sessions
  post    'sessions/new',     to: 'sessions#create'
  delete  'sessions',         to: 'sessions#destroy', as: :session

######### USERS ROUTES
  get     'users/index',      to: 'users#index',      as: :users
  get     'users/new',        to: 'users#new',        as: :create_user
  post    'users/new',        to: 'users#create'
  get     'users/:id',        to: 'users#show',       as: :user
  get     'users/:id/edit',   to: 'users#edit',       as: :edit_user
  patch   'users/:id/',       to: 'users#update'
  delete  'users/:id',        to: 'users#destroy'

  get     '/admin',           to: 'users#admin',      as: :admin
  patch   '/admin',           to: 'users#make_admin'

######### SHARED ITEMS ROUTES
  get '/library',             to: 'shared_items#index',     as: :library
  post '/library/checkout',   to: 'shared_items#checkout',  as: :ajax_checkout
  post '/library',            to: 'shared_items#create'
  patch '/library',           to: 'shared_items#checkout'
  patch '/return',            to: 'shared_items#update',    as: :return
######### ARTICLES ROUTES
  get     'articles',         to: 'articles#index',   as: :articles
  post    'articles',         to: 'articles#create'
  get     'articles/new',     to: 'articles#new',     as: :create_article
  get     'articles/:id/',    to: 'articles#show',    as: :article
  get 'articles/:id/edit',    to: 'articles#edit',    as: :edit_article
  patch   'articles/:id/',    to: 'articles#update'
  delete  'articles/:id',     to: 'articles#destroy'

######### COMMENTS ROUTES
  get     'articles/:id/comments',      to: 'comments#index',  as: :comments
  post    'articles/:id/comments',      to: 'comments#create'
  get     'comments/:id',       to: 'comments#show', as: :comment
  get     'comments/:id/edit',  to: 'comments#edit', as: :edit_comment
  patch   'comments/:id',       to: 'comments#update'
  delete  'comments/:id',       to: 'comments#destroy'

######### EVENTS ROUTES

  get     'calendar',         to: 'events#index',   as: :calendar
  post    'events',           to: 'events#create',  as: :events
  get     'events/new',       to: 'events#new',     as: :create_event
  get     'events/:id',       to: 'events#show',    as: :event
  get     'events/:id/edit',  to: 'events#edit',    as: :edit_event
  patch   'events/:id',       to: 'events#update'
  delete  'events/:id',       to: 'events#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
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
