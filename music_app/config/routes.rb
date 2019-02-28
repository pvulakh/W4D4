Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :session #singular, generates routes for new_session, edit_session, show_session
  resources :bands
end
