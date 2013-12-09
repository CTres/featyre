Blog::Application.routes.draw do
    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"},
                     :sign_out_via => [ :post, :delete ]

  root to: 'features#index'
  
  #resources :collaborators
  match "features/:id/add_collaborator" => "features#add_collaborator", as: 'add_collaborator'
  match "features/:id/remove_collaborator" => "features#remove_collaborator", as: 'remove_collaborator'
  match "users/:id/update_feature_user" => "users#update_feature_user", as: 'update_feature_user'
  match "features/:id/add_image" => "features#add_image", as: 'add_image'
  
  resources :features do
    get :autocomplete_tag_name, :on => :collection
    resources :values do
    end
  end
      resources :users 
      resources :photos
end
