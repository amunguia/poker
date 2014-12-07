Poker::Application.routes.draw do
  get "sessions/new"
  get "users/new"

  #navbar
  get "home" => "static_pages#home", :as => "home"
  get "play" => "rooms#index", :as => "play"
  get "account" => "sessions#account", :as => "account"
  get "rules" => "static_pages#rules", :as => "rules"

  #login and registration
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "logged_in" => "static_pages#logged_in", :as => "logged_in"
  post "join_game" => "games#join_game", :as => "join_game"
  get "get_cards" => "games#get_cards", :as => "get_cards"
  post "move" => "games#move", :as => "move"
  get "register" => "users#new", :as => "register"
  
  root :to => "static_pages#home"
  get "game_status" => "games#get_game", :as => "game_status"
  get "tables/:id/game_id" => "tables#get_game", :as => "game_for_table"
  resources :users
  resources :sessions
  resources :rooms
  resources :tables  

  get "show_template" => "tables#show_template"

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
