Rails.application.routes.draw do
  resources :products, only: [:create, :new, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
