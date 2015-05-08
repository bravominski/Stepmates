Rails.application.routes.draw do
  resources :patients
  resources :users

  get     'graph_data' => 'patients#data', :defaults => { :format => 'json' }
  get     'login'   => 'sessions#new' # login page
  post    'login'   => 'sessions#create' # pressing login button from login page
  get     'logout'  => 'sessions#destroy' # logout
  get     'signup' => 'users#new' # creating a new user account
  get  'patients/:id/email', :to => 'patients#custom_email', :as => 'custom_email_patient'
  post 'patients/:id/email', :to => 'patients#send_email', :as => 'send_email_patient'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new' # root of the site(login page)

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'moves/getauth' => 'moves#getAuth'
  get 'addpatient' => 'moves#receiveAuth'
  get 'moves/getdata' => 'moves#getData'
  get 'showall' => 'moves#showall'

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
