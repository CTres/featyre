Blog::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"},
                     :sign_out_via => [ :post, :delete ]
  
  root to: 'features#index'
  
  #resources :users
  #resources :collaborators
  resources :features do
  	get :autocomplete_tag_name, :on => :collection
  end
  
end
