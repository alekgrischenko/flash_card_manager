FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  resources :cards
  resources :users
  resources :user_sessions
  
  put 'check_translation',  to: 'review#check_translation'
  get 'login',              to: 'user_sessions#new',     as: :login
  post 'logout',            to: 'user_sessions#destroy', as: :logout
end
