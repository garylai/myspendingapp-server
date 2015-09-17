Rails.application.routes.draw do

  scope '/api' do
    scope '/v1' do
      scope '/user' do
        post '/' => 'user#create', :format => false
        post '/token' => 'user#login', :format => false
      end
      scope '/spending' do
        post '/' => 'spending#create', :format => false
      end
      scope '/spending_type' do
        get '/' => 'spending_type#index', :format => false
      end
      get '(/year/:year(/month/:month(/day/:day)))/spendings' => 'spending#index',
                                                        :format => false,
                                                    :constraints => { year: /\d+/, month: /\d+/, day: /\d+/ }
    end
  end

  get "/404", :to => "error#not_found"
  get "/400", :to => "error#bad_request"
  get "/500", :to => "error#internal_server_error"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'

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
