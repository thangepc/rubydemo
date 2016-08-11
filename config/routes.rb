Rails.application.routes.draw do

  # Client
  get '/' => 'client#index', as: :index
  get '/product/:id' => 'client#detail', as: :detail_product
  get '/cate/:id' => 'client#categories', as: :categories
  get '/products' => 'client#products', as: :products
  match '/register', to: 'users#signup', via: [:get, :post], as: :signup
  match '/signin', to: 'users#signin', via: [:get, :post], as: :signin
  get '/logout', to: 'users#logout', as: :logout
  post '/post-comment' => 'client#comment', as: :post_comment
  post '/buy-now' => 'client#buynow', as: :buynow
  get '/cart' => 'client#cart', as: :cart
  post '/update-cart' => 'client#update_cart', as: :update_cart
  post '/delete-product-cart' => 'client#delete_cart', as: :delete_cart
  match '/booking', to: 'client#booking', via: [:get, :post], as: :booking
  get '/booking-info', to: 'client#booking_info', as: :booking_info





  get '/admin/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  # Category
    get '/admin/categories' => 'categories#index', as: :index_category
  match '/admin/categories/create', to: 'categories#create', via: [:get, :post], as: :create_category
  match '/admin/categories/:id', to: 'categories#edit', via: [:get, :patch], as: :edit_category
  post '/admin/categories/:id' => 'categories#delete', as: :delete_category

  # Products
  get '/admin/products' => 'products#index', as: :index_product
  match '/admin/products/create', to: 'products#create', via: [:get, :post], as: :create_product
  match '/admin/products/:id', to: 'products#edit', via: [:get, :patch], as: :edit_product
  post '/admin/products/:id' => 'products#delete', as: :delete_product

  # Admin
  get '/admin/signup' => 'admins#signup', as: :register
  # resources :admins
  match '/admin/login' => 'sessions#login', via: [:get, :post], as: :login
  get '/admin/logout' => 'sessions#logout', as: :signout
  match '/admin/dashboard' => 'admins#dashboard', via: [:get, :post], as: :dashboard
  get '/admins' => 'admins#index', as: :admin_manager
  post '/admins/change_status', to: 'admins#change_status', as: :change_status_admins
  match '/admins/create', to: 'admins#create', via: [:get, :post], as: :create_admins
  match '/admins/:id', to: 'admins#edit', via: [:get, :patch], as: :edit_admins
  post '/admins/:id', to: 'admins#delete', as: :delete_admins

  # Order Admin
  get '/admin/orders' => 'orders#index', as: :orders
  post '/admin/chang-status-order' => 'orders#change_status', as: :change_status_orders

  #Users
  get '/admin/users' => 'users#index', as: :users
  post '/admin/users/change_status', to: 'users#change_status', as: :change_status_users


  # Upload file
  match '/upload_files' => 'settings#upload_files', via: [:get, :post], as: :upload_files
  match '/delete_file' => 'settings#delete_file', via: [:get, :post], as: :delete_file
  match '/files_sort' => 'settings#files_sort', via: [:get, :post], as: :files_sort


  # Login Facebook
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signouts'

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
