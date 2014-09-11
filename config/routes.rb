Rails.application.routes.draw do
  resources :transactions

  resources :wallets
  get 'wallets/:id/export' => 'wallets#export'
  post 'wallets/new' => 'wallets#import'

  # post 'new_receiving_qrcode' => 'wallets#new_receiving_qrcode', as: 'gen_receiving_qrcode'
  get 'receiverqrcode/new' => 'receiverqrcode#new'
  post 'receiverqrcode' => 'receiverqrcode#create'

  # redirect other requests to home
  get 'receiverqrcode' => 'home#index'
  patch 'receiverqrcode' => 'home#index'
  delete 'receiverqrcode' => 'home#index'

  # redirect 'edit transaction'
  get 'transactions/:id/edit' => 'transactions#redirect'
  patch 'transactions/:id' => 'transactions#redirect'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root :to => "home#index"

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
