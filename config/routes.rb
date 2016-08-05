Rails.application.routes.draw do

  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  # Category
  get '/categories' => 'categories#index'
  match '/categories/create', to: 'categories#create', via: [:get, :post], as: :create_category
  match '/categories/:id', to: 'categories#edit', via: [:get, :patch], as: :edit_category
  post '/categories/:id' => 'categories#delete', as: :delete_category

  # Products
  get '/products' => 'products#index'
  match '/products/create', to: 'products#create', via: [:get, :post], as: :create_product
  match '/products/:id', to: 'products#edit', via: [:get, :patch], as: :edit_product
  post '/products/:id' => 'products#delete', as: :delete_product

  # Admin
  get '/signup' => 'admins#signup'
  # resources :admins
  match '/login' => 'sessions#login', via: [:get, :post], as: :login
  get '/logout' => 'sessions#logout'
  match '/dashboard' => 'admins#dashboard', via: [:get, :post], as: :dashboard
  get '/admins' => 'admins#index'
  post '/admins/change_status', to: 'admins#change_status', as: :change_status_admins
  match '/admins/create', to: 'admins#create', via: [:get, :post], as: :create_admins
  match '/admins/:id', to: 'admins#edit', via: [:get, :patch], as: :edit_admins
  post '/admins/:id', to: 'admins#delete', as: :delete_admins



  # Upload file
  match '/upload_files' => 'settings#upload_files', via: [:get, :post], as: :upload_files
  match '/delete_file' => 'settings#delete_file', via: [:get, :post], as: :delete_file
  match '/files_sort' => 'settings#files_sort', via: [:get, :post], as: :files_sort


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
